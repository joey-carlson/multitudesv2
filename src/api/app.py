"""
FastAPI Application for Multitudes.

Main API server with authentication and context management endpoints.
Runs on port 2701.
"""

from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from fastapi.middleware.cors import CORSMiddleware
from datetime import datetime
from typing import Optional

from .models import (
    LoginRequest,
    LoginResponse,
    UserInfo,
    UserContextResponse,
    ContextStatsResponse,
    UpdateContextRequest,
    FeedbackRequest,
    FeedbackResponse,
    ErrorResponse,
)
from .auth import (
    create_access_token,
    decode_access_token,
    get_user_from_passphrase,
    hash_passphrase,
)
from ..shared.database.postgres_storage import PostgresContextStorage
from ..core.learning.context_manager import ContextManager
from ..core.models.user_context import ContextType, LearnedFrom, UserFeedback


# Initialize FastAPI
app = FastAPI(
    title="Multitudes API",
    description="Multi-user personal AI assistant with adaptive context learning",
    version="2.0.0",
)

# CORS middleware for Streamlit dashboard
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:2700", "http://127.0.0.1:2700"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Security
security = HTTPBearer()

# Global storage and context manager (initialized on startup)
storage: Optional[PostgresContextStorage] = None
context_manager: Optional[ContextManager] = None


@app.on_event("startup")
async def startup_event():
    """Initialize storage backend on startup"""
    global storage, context_manager
    storage = PostgresContextStorage()
    context_manager = ContextManager(storage)
    print("✅ Storage backend initialized")


@app.on_event("shutdown")
async def shutdown_event():
    """Cleanup on shutdown"""
    global storage
    if storage:
        await storage.close()
    print("👋 Storage backend closed")


# Dependency to get current user from JWT token
async def get_current_user(
    credentials: HTTPAuthorizationCredentials = Depends(security)
) -> str:
    """
    Extract and validate user ID from JWT token.
    
    Returns:
        user_id
        
    Raises:
        HTTPException: If token is invalid
    """
    token = credentials.credentials
    payload = decode_access_token(token)
    
    if payload is None:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid or expired token",
        )
    
    user_id = payload.get("sub")
    if not user_id:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid token payload",
        )
    
    return user_id


# Health check
@app.get("/health")
async def health_check():
    """Health check endpoint"""
    return {
        "status": "healthy",
        "timestamp": datetime.utcnow().isoformat(),
        "version": "2.0.0",
    }


# Authentication Endpoints

@app.post("/auth/login", response_model=LoginResponse)
async def login(request: LoginRequest):
    """
    Authenticate user with passphrase.
    
    Returns JWT token for authenticated requests.
    """
    # Check against predefined passphrases
    user_info = get_user_from_passphrase(request.passphrase)
    
    if not user_info:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid passphrase",
        )
    
    user_id = user_info["user_id"]
    display_name = user_info.get("display_name")
    
    # Check if user exists, create if not
    existing_user = await storage.get_user_by_id(user_id)
    if not existing_user:
        # Create new user
        await storage.create_user(
            user_id=user_id,
            display_name=display_name,
            passphrase_hash=hash_passphrase(request.passphrase),
        )
    else:
        # Update last login
        await storage.update_last_login(user_id)
    
    # Create access token
    access_token = create_access_token(data={"sub": user_id})
    
    return LoginResponse(
        access_token=access_token,
        token_type="bearer",
        user_id=user_id,
        display_name=display_name,
    )


@app.get("/auth/me", response_model=UserInfo)
async def get_current_user_info(
    current_user_id: str = Depends(get_current_user)
):
    """Get current user information"""
    user = await storage.get_user_by_id(current_user_id)
    
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="User not found",
        )
    
    return UserInfo(
        user_id=user.id,
        display_name=user.display_name,
        email=user.email,
        created_at=user.created_at,
        last_login=user.last_login,
    )


# Context Endpoints

@app.get("/api/context", response_model=UserContextResponse)
async def get_user_context(
    current_user_id: str = Depends(get_current_user)
):
    """
    Get aggregated user context.
    
    Returns personalized patterns, preferences, and statistics.
    """
    user_context = await context_manager.get_context(current_user_id)
    
    return UserContextResponse(
        user_id=user_context.user_id,
        preferences=user_context.preferences,
        patterns=user_context.patterns,
        stats=user_context.stats,
        persona_affinities=user_context.persona_affinities,
    )


@app.get("/api/context/stats", response_model=ContextStatsResponse)
async def get_context_stats(
    current_user_id: str = Depends(get_current_user)
):
    """Get statistics about user's context"""
    stats = await context_manager.get_context_statistics(current_user_id)
    
    return ContextStatsResponse(
        total_contexts=stats["total_contexts"],
        by_type=stats["by_type"],
        by_source=stats["by_source"],
        average_confidence=stats["average_confidence"],
        oldest_context=stats["oldest_context"],
        newest_context=stats["newest_context"],
    )


@app.post("/api/context", response_model=dict)
async def update_context(
    request: UpdateContextRequest,
    current_user_id: str = Depends(get_current_user)
):
    """
    Update or create a context item.
    
    Used to manually set preferences or patterns.
    """
    try:
        context_type = ContextType(request.context_type)
    except ValueError:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=f"Invalid context type: {request.context_type}",
        )
    
    await context_manager.update_context(
        user_id=current_user_id,
        context_type=context_type,
        key=request.key,
        value=request.value,
        confidence=request.confidence,
        learned_from=LearnedFrom.EXPLICIT,
    )
    
    return {
        "success": True,
        "message": f"Context updated: {request.key}",
    }


@app.post("/api/feedback", response_model=FeedbackResponse)
async def submit_feedback(
    request: FeedbackRequest,
    current_user_id: str = Depends(get_current_user)
):
    """
    Submit user feedback for continuous learning.
    
    The system learns from accept/reject/modify actions.
    """
    # Save feedback
    feedback = UserFeedback(
        id=None,
        user_id=current_user_id,
        interaction_type=request.interaction_type,
        interaction_data=request.interaction_data,
        feedback_type=request.feedback_type,
        feedback_data=request.feedback_data,
        created_at=datetime.utcnow(),
    )
    
    await storage.save_feedback(feedback)
    
    # Process feedback to update context
    await context_manager.learn_from_feedback(
        user_id=current_user_id,
        interaction_type=request.interaction_type,
        feedback_type=request.feedback_type,
        feedback_data=request.feedback_data,
    )
    
    return FeedbackResponse(
        success=True,
        message="Feedback received and processed",
    )


# Error handlers
@app.exception_handler(HTTPException)
async def http_exception_handler(request, exc):
    """Custom HTTP exception handler"""
    return ErrorResponse(
        detail=exc.detail,
        error_type=exc.__class__.__name__,
    )


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=2701)
