"""
Pydantic Models for FastAPI.

Defines request/response schemas for API endpoints.
"""

from typing import Optional, List, Dict, Any
from datetime import datetime
from pydantic import BaseModel, Field


# Authentication Models

class LoginRequest(BaseModel):
    """Login request with passphrase"""
    passphrase: str = Field(..., min_length=3, description="User passphrase")


class LoginResponse(BaseModel):
    """Login response with JWT token"""
    access_token: str = Field(..., description="JWT access token")
    token_type: str = Field(default="bearer", description="Token type")
    user_id: str = Field(..., description="User ID")
    display_name: Optional[str] = Field(None, description="User display name")


class UserInfo(BaseModel):
    """Current user information"""
    user_id: str
    display_name: Optional[str] = None
    email: Optional[str] = None
    created_at: datetime
    last_login: Optional[datetime] = None


# Context Models

class ContextItemResponse(BaseModel):
    """Single context item"""
    id: str
    context_type: str
    key: str
    value: Any
    confidence: float
    weight: float
    learned_from: str
    created_at: datetime
    updated_at: datetime


class UserContextResponse(BaseModel):
    """Aggregated user context"""
    user_id: str
    preferences: Dict[str, Any] = Field(default_factory=dict)
    patterns: List[str] = Field(default_factory=list)
    stats: Dict[str, float] = Field(default_factory=dict)
    persona_affinities: Dict[str, float] = Field(default_factory=dict)


class ContextStatsResponse(BaseModel):
    """Context statistics"""
    total_contexts: int
    by_type: Dict[str, int]
    by_source: Dict[str, int]
    average_confidence: float
    oldest_context: Optional[datetime] = None
    newest_context: Optional[datetime] = None


class UpdateContextRequest(BaseModel):
    """Request to update context"""
    context_type: str = Field(..., description="Type: preference, pattern, stat, persona_affinity")
    key: str = Field(..., description="Context key")
    value: Any = Field(..., description="Context value")
    confidence: float = Field(1.0, ge=0.0, le=1.0, description="Confidence score")


class FeedbackRequest(BaseModel):
    """User feedback submission"""
    interaction_type: str = Field(..., description="Type of interaction")
    interaction_data: Dict[str, Any] = Field(..., description="Interaction details")
    feedback_type: str = Field(..., description="accepted, rejected, or modified")
    feedback_data: Dict[str, Any] = Field(default_factory=dict, description="Feedback details")


class FeedbackResponse(BaseModel):
    """Feedback submission response"""
    success: bool
    message: str


# Error Models

class ErrorResponse(BaseModel):
    """Standard error response"""
    detail: str
    error_type: Optional[str] = None
    timestamp: datetime = Field(default_factory=datetime.utcnow)
