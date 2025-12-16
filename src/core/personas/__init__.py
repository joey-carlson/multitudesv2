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
)

__all__ = [
    "Persona",
    "EnergyReading",
    "PersonaArchetype",
    "TriggerCondition",
]
