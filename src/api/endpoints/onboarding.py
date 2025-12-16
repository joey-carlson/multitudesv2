"""
Onboarding API endpoints for Multitudes.

Handles the first-time setup experience where users complete
the persona discovery survey and their personas are created.

Following ClineRules:
- Rule #06: FastAPI with proper type hints and error handling
- Rule #09: Security, validation, rate limiting
"""

from typing import List, Dict, Any
from datetime import datetime

from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import HTTPBearer
from sqlalchemy.ext.asyncio import AsyncSession
from pydantic import BaseModel, Field

from src.shared.database.postgres_storage import get_db
from src.shared.database.models import User, Persona as PersonaDB
from src.core.personas import (
    generate_personas_from_survey,
    get_survey_config,
    Persona as PersonaModel
)

router = APIRouter(prefix="/onboarding", tags=["onboarding"])


# Request/Response Models
class SurveyResponse(BaseModel):
    """Survey response from user."""
    responses: Dict[str, Any] = Field(..., description="Survey question responses")
    
    class Config:
        json_schema_extra = {
            "example": {
                "responses": {
                    "archetypes_selection": [
                        "🧠 The Professional - Responsible, structured, goal-focused"
                    ],
                    "custom_persona_names": "Executive Emma",
                    "overall_energy_pattern": "Mid-morning (9am-12pm)",
                    "weekly_time_allocation": "Work: 40hrs"
                }
            }
        }


class PersonaResponse(BaseModel):
    """Persona response model."""
    id: str
    name: str
    emoji: str
    archetype: str
    primary_energy: str
    ideal_weekly_hours: float
    
    class Config:
        from_attributes = True


class OnboardingCompletionResponse(BaseModel):
    """Response after completing onboarding."""
    personas_created: int
    personas: List[PersonaResponse]
    message: str


@router.get("/survey")
async def get_survey() -> Dict[str, Any]:
    """
    Get the onboarding survey configuration.
    
    Returns the complete 5-phase survey structure with all questions.
    """
    return get_survey_config()


async def get_current_user_dep(
    credentials = Depends(HTTPBearer())
) -> str:
    """Get current user from JWT token."""
    from src.api.auth import decode_access_token
    from fastapi import HTTPException, status as http_status
    
    token = credentials.credentials
    payload = decode_access_token(token)
    
    if payload is None:
        raise HTTPException(
            status_code=http_status.HTTP_401_UNAUTHORIZED,
            detail="Invalid or expired token"
        )
    
    user_id = payload.get("sub")
    if not user_id:
        raise HTTPException(
            status_code=http_status.HTTP_401_UNAUTHORIZED,
            detail="Invalid token payload"
        )
    
    return user_id


@router.get("/status")
async def get_onboarding_status(
    current_user: str = Depends(get_current_user_dep),
    db: AsyncSession = Depends(get_db)
) -> Dict[str, Any]:
    """
    Check if user has completed onboarding.
    
    Returns whether user has personas set up.
    """
    # Query persona count for user
    result = await db.execute(
        "SELECT COUNT(*) FROM personas WHERE user_id = :user_id AND is_active = true",
        {"user_id": current_user}
    )
    persona_count = result.scalar()
    
    return {
        "completed": persona_count > 0,
        "persona_count": persona_count,
        "user_id": current_user
    }


@router.post("/submit", response_model=OnboardingCompletionResponse)
async def submit_onboarding(
    survey_data: SurveyResponse,
    current_user: str = Depends(get_current_user_dep),
    db: AsyncSession = Depends(get_db)
) -> OnboardingCompletionResponse:
    """
    Submit completed onboarding survey and create personas.
    
    Processes survey responses, generates personas, and stores them in the database.
    """
    try:
        # Generate personas from survey responses
        personas: List[PersonaModel] = generate_personas_from_survey(
            user_id=current_user,
            survey_responses=survey_data.responses
        )
        
        if not personas:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="No personas could be generated from survey responses"
            )
        
        # Convert persona models to database models and save
        db_personas = []
        for persona in personas:
            # Convert time objects to strings for database
            peak_start = persona.peak_start_time.strftime("%H:%M") if persona.peak_start_time else None
            peak_end = persona.peak_end_time.strftime("%H:%M") if persona.peak_end_time else None
            trough_start = persona.trough_start_time.strftime("%H:%M") if persona.trough_start_time else None
            trough_end = persona.trough_end_time.strftime("%H:%M") if persona.trough_end_time else None
            recovery_start = persona.recovery_start_time.strftime("%H:%M") if persona.recovery_start_time else None
            recovery_end = persona.recovery_end_time.strftime("%H:%M") if persona.recovery_end_time else None
            
            db_persona = PersonaDB(
                id=persona.id,
                user_id=persona.user_id,
                name=persona.name,
                emoji=persona.emoji,
                archetype=persona.archetype.value,
                primary_energy=persona.primary_energy,
                strengths=persona.strengths,
                weaknesses=persona.weaknesses,
                trigger_conditions=persona.trigger_conditions,
                ideal_tasks=persona.ideal_tasks,
                peak_start_time=peak_start,
                peak_end_time=peak_end,
                trough_start_time=trough_start,
                trough_end_time=trough_end,
                recovery_start_time=recovery_start,
                recovery_end_time=recovery_end,
                ideal_weekly_hours=persona.ideal_weekly_hours,
                actual_weekly_hours=persona.actual_weekly_hours,
                is_active=True,
                created_at=datetime.utcnow(),
                updated_at=datetime.utcnow()
            )
            db.add(db_persona)
            db_personas.append(db_persona)
        
        # Commit all personas
        await db.commit()
        
        # Refresh to get IDs
        for db_persona in db_personas:
            await db.refresh(db_persona)
        
        # Convert to response models
        persona_responses = [
            PersonaResponse(
                id=p.id,
                name=p.name,
                emoji=p.emoji,
                archetype=p.archetype,
                primary_energy=p.primary_energy or "",
                ideal_weekly_hours=p.ideal_weekly_hours
            )
            for p in db_personas
        ]
        
        return OnboardingCompletionResponse(
            personas_created=len(db_personas),
            personas=persona_responses,
            message=f"Successfully created {len(db_personas)} persona(s)!"
        )
        
    except Exception as e:
        await db.rollback()
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to create personas: {str(e)}"
        )


@router.get("/personas", response_model=List[PersonaResponse])
async def get_user_personas(
    current_user: str = Depends(get_current_user_dep),
    db: AsyncSession = Depends(get_db)
) -> List[PersonaResponse]:
    """
    Get all personas for the current user.
    
    Returns list of user's active personas.
    """
    result = await db.execute(
        """
        SELECT id, name, emoji, archetype, primary_energy, ideal_weekly_hours
        FROM personas
        WHERE user_id = :user_id AND is_active = true
        ORDER BY created_at ASC
        """,
        {"user_id": current_user}
    )
    
    personas = result.fetchall()
    
    return [
        PersonaResponse(
            id=row[0],
            name=row[1],
            emoji=row[2],
            archetype=row[3],
            primary_energy=row[4] or "",
            ideal_weekly_hours=row[5]
        )
        for row in personas
    ]
