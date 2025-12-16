"""
Persona management module for Multitudes v2.0.

This module handles the core persona system - the "multitudes" within each user.
Each persona represents a distinct aspect of the user's identity with unique
energy patterns, strengths, and ideal tasks.

Based on the original Multitudes v1 concept and enhanced with research-backed
energy patterns (Peak-Trough-Recovery model).
"""

from .persona_models import (
    Persona,
    EnergyReading,
    PersonaArchetype,
    TriggerCondition,
    ARCHETYPE_TEMPLATES,
)
from .persona_generator import (
    PersonaGenerator,
    generate_personas_from_survey,
)
from .survey_config import (
    SurveyQuestion,
    SurveyPhase,
    ONBOARDING_SURVEY,
    get_survey_config,
    get_phase_by_id,
    get_question_by_id,
)

__all__ = [
    # Models
    "Persona",
    "EnergyReading",
    "PersonaArchetype",
    "TriggerCondition",
    "ARCHETYPE_TEMPLATES",
    # Generator
    "PersonaGenerator",
    "generate_personas_from_survey",
    # Survey
    "SurveyQuestion",
    "SurveyPhase",
    "ONBOARDING_SURVEY",
    "get_survey_config",
    "get_phase_by_id",
    "get_question_by_id",
]
