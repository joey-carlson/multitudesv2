"""
Persona generation from onboarding survey responses.

Converts user survey answers into Persona objects with energy patterns,
strengths, weaknesses, and ideal tasks configured.

Following ClineRules:
- Rule #03: Type hints throughout
- Rule #02: Single responsibility - just persona generation
- Rule #05: Domain logic for persona creation
"""

from typing import List, Dict, Any, Optional
from datetime import time
import re

from .persona_models import (
    Persona,
    PersonaArchetype,
    ARCHETYPE_TEMPLATES,
    PersonaArchetypeTemplate
)


class PersonaGenerator:
    """
    Generates Persona objects from onboarding survey responses.
    
    Handles:
    - Mapping archetype selections to templates
    - Customizing names and energy patterns
    - Setting up energy timings from survey responses
    - Configuring ideal weekly hours
    """
    
    def __init__(self, user_id: str):
        """
        Initialize persona generator for a specific user.
        
        Args:
            user_id: The user these personas belong to
        """
        self.user_id = user_id
    
    def generate_personas_from_survey(
        self,
        survey_responses: Dict[str, Any]
    ) -> List[Persona]:
        """
        Generate persona objects from complete survey responses.
        
        Args:
            survey_responses: Dictionary of question_id -> answer
            
        Returns:
            List of configured Persona objects
            
        Example:
            responses = {
                "archetypes_selection": ["🧠 The Professional", "🎨 The Artist"],
                "custom_persona_names": "Executive Emma, Creative Chris",
                "overall_energy_pattern": "Mid-morning (9am-12pm)",
                ...
            }
            personas = generator.generate_personas_from_survey(responses)
        """
        personas = []
        
        # Extract selected archetypes
        selected_archetypes = self._parse_archetype_selection(
            survey_responses.get("archetypes_selection", [])
        )
        
        # Parse custom names if provided
        custom_names = self._parse_custom_names(
            survey_responses.get("custom_persona_names", ""),
            len(selected_archetypes)
        )
        
        # Extract energy patterns
        energy_config = self._extract_energy_config(survey_responses)
        
        # Extract time allocation
        time_allocation = self._parse_time_allocation(
            survey_responses.get("weekly_time_allocation", "")
        )
        
        # Generate persona for each selected archetype
        for idx, archetype in enumerate(selected_archetypes):
            template = ARCHETYPE_TEMPLATES.get(archetype)
            if not template:
                continue
            
            # Use custom name if provided, otherwise use template default
            persona_name = (
                custom_names[idx] 
                if idx < len(custom_names) 
                else template.default_name
            )
            
            # Get ideal weekly hours for this persona
            ideal_hours = time_allocation.get(persona_name, 0.0)
            if ideal_hours == 0.0:
                ideal_hours = time_allocation.get(template.default_name, 0.0)
            
            persona = self._create_persona_from_template(
                template=template,
                custom_name=persona_name,
                energy_config=energy_config,
                ideal_weekly_hours=ideal_hours
            )
            
            personas.append(persona)
        
        return personas
    
    def _parse_archetype_selection(
        self,
        selections: List[str]
    ) -> List[PersonaArchetype]:
        """
        Parse archetype selections from survey response.
        
        Args:
            selections: List of selected archetype strings
            
        Returns:
            List of PersonaArchetype enums
        """
        archetypes = []
        
        for selection in selections:
            # Extract emoji from selection to match archetype
            if "🧠" in selection:
                archetypes.append(PersonaArchetype.PROFESSIONAL)
            elif "🌈" in selection:
                archetypes.append(PersonaArchetype.INNER_CHILD)
            elif "🎨" in selection:
                archetypes.append(PersonaArchetype.ARTIST)
            elif "🛠" in selection:
                archetypes.append(PersonaArchetype.BUILDER)
            elif "🛡" in selection:
                archetypes.append(PersonaArchetype.GUARDIAN)
            elif "📐" in selection:
                archetypes.append(PersonaArchetype.ARCHITECT)
            elif "🗃" in selection:
                archetypes.append(PersonaArchetype.HISTORIAN)
            elif "🤖" in selection:
                archetypes.append(PersonaArchetype.OPTIMIZER)
            elif "✨" in selection:
                archetypes.append(PersonaArchetype.CUSTOM)
        
        return archetypes
    
    def _parse_custom_names(
        self,
        custom_names_text: str,
        expected_count: int
    ) -> List[str]:
        """
        Parse custom persona names from text input.
        
        Args:
            custom_names_text: Comma-separated names
            expected_count: Number of personas to generate names for
            
        Returns:
            List of custom names (may be empty)
        """
        if not custom_names_text or not custom_names_text.strip():
            return []
        
        # Split by commas, clean whitespace
        names = [
            name.strip() 
            for name in custom_names_text.split(",") 
            if name.strip()
        ]
        
        return names
    
    def _extract_energy_config(
        self,
        survey_responses: Dict[str, Any]
    ) -> Dict[str, Any]:
        """
        Extract energy pattern configuration from survey.
        
        Args:
            survey_responses: Full survey response dictionary
            
        Returns:
            Dictionary with peak, trough, recovery times
        """
        config = {
            "peak_start": None,
            "peak_end": None,
            "trough_start": None,
            "trough_end": None,
            "recovery_start": None,
            "recovery_end": None
        }
        
        # Parse overall energy pattern
        energy_pattern = survey_responses.get("overall_energy_pattern", "")
        
        if "Early morning (5am-9am)" in energy_pattern:
            config["peak_start"] = time(5, 0)
            config["peak_end"] = time(9, 0)
        elif "Mid-morning (9am-12pm)" in energy_pattern:
            config["peak_start"] = time(9, 0)
            config["peak_end"] = time(12, 0)
        elif "Early afternoon (12pm-3pm)" in energy_pattern:
            config["peak_start"] = time(12, 0)
            config["peak_end"] = time(15, 0)
        elif "Late afternoon (3pm-6pm)" in energy_pattern:
            config["peak_start"] = time(15, 0)
            config["peak_end"] = time(18, 0)
        elif "Evening (6pm-10pm)" in energy_pattern:
            config["peak_start"] = time(18, 0)
            config["peak_end"] = time(22, 0)
        elif "Late night (10pm-2am)" in energy_pattern:
            config["peak_start"] = time(22, 0)
            config["peak_end"] = time(2, 0)
        
        # Parse energy dip if indicated
        has_dip = survey_responses.get("energy_dip", "")
        if "Yes" in has_dip or "Sometimes" in has_dip:
            dip_time = survey_responses.get("energy_dip_time", "")
            
            if "Late morning (10am-12pm)" in dip_time:
                config["trough_start"] = time(10, 0)
                config["trough_end"] = time(12, 0)
            elif "Early afternoon (12pm-2pm)" in dip_time:
                config["trough_start"] = time(12, 0)
                config["trough_end"] = time(14, 0)
            elif "Mid-afternoon (2pm-4pm)" in dip_time:
                config["trough_start"] = time(14, 0)
                config["trough_end"] = time(16, 0)
            elif "Early evening (5pm-7pm)" in dip_time:
                config["trough_start"] = time(17, 0)
                config["trough_end"] = time(19, 0)
        
        # Set recovery period (typically after trough)
        if config["trough_end"]:
            # Recovery starts when trough ends
            trough_end_hour = config["trough_end"].hour
            config["recovery_start"] = config["trough_end"]
            config["recovery_end"] = time((trough_end_hour + 2) % 24, 0)
        
        return config
    
    def _parse_time_allocation(
        self,
        time_allocation_text: str
    ) -> Dict[str, float]:
        """
        Parse weekly time allocation from text.
        
        Args:
            time_allocation_text: Text like "Work: 40hrs, Creative: 5hrs"
            
        Returns:
            Dictionary mapping persona names to hours
        """
        allocation = {}
        
        if not time_allocation_text or not time_allocation_text.strip():
            return allocation
        
        # Parse patterns like "Work: 40hrs" or "Creative: 5"
        pattern = r'([^:,]+):\s*(\d+(?:\.\d+)?)\s*(?:hrs?)?'
        matches = re.findall(pattern, time_allocation_text, re.IGNORECASE)
        
        for persona_name, hours_str in matches:
            try:
                hours = float(hours_str)
                allocation[persona_name.strip()] = hours
            except ValueError:
                continue
        
        return allocation
    
    def _create_persona_from_template(
        self,
        template: PersonaArchetypeTemplate,
        custom_name: str,
        energy_config: Dict[str, Any],
        ideal_weekly_hours: float = 0.0
    ) -> Persona:
        """
        Create a Persona object from archetype template and customizations.
        
        Args:
            template: The archetype template to use
            custom_name: Custom name for this persona
            energy_config: Energy pattern configuration
            ideal_weekly_hours: Weekly hour allocation
            
        Returns:
            Configured Persona object
        """
        # Use energy config from survey, fall back to template defaults
        peak_start = energy_config.get("peak_start") or template.typical_peak_start
        peak_end = energy_config.get("peak_end") or template.typical_peak_end
        
        persona = Persona(
            user_id=self.user_id,
            name=custom_name,
            emoji=template.emoji,
            archetype=template.archetype,
            primary_energy=template.primary_energy,
            strengths=template.common_strengths.copy(),
            weaknesses=template.common_weaknesses.copy(),
            trigger_conditions=template.typical_triggers.copy(),
            ideal_tasks=template.ideal_task_categories.copy(),
            peak_start_time=peak_start,
            peak_end_time=peak_end,
            trough_start_time=energy_config.get("trough_start"),
            trough_end_time=energy_config.get("trough_end"),
            recovery_start_time=energy_config.get("recovery_start"),
            recovery_end_time=energy_config.get("recovery_end"),
            ideal_weekly_hours=ideal_weekly_hours,
            actual_weekly_hours=0.0,
            is_active=True
        )
        
        return persona
    
    def create_custom_persona(
        self,
        name: str,
        emoji: str = "✨",
        primary_energy: str = "",
        strengths: Optional[List[str]] = None,
        weaknesses: Optional[List[str]] = None,
        trigger_conditions: Optional[List[str]] = None,
        ideal_tasks: Optional[List[str]] = None,
        energy_config: Optional[Dict[str, Any]] = None,
        ideal_weekly_hours: float = 0.0
    ) -> Persona:
        """
        Create a fully custom persona not based on templates.
        
        Args:
            name: Persona name
            emoji: Visual identifier
            primary_energy: Core characteristics
            strengths: List of strengths
            weaknesses: List of weaknesses
            trigger_conditions: What activates this persona
            ideal_tasks: What tasks this persona handles
            energy_config: Energy pattern configuration
            ideal_weekly_hours: Weekly time allocation
            
        Returns:
            Configured custom Persona object
        """
        energy_cfg = energy_config or {}
        
        persona = Persona(
            user_id=self.user_id,
            name=name,
            emoji=emoji,
            archetype=PersonaArchetype.CUSTOM,
            primary_energy=primary_energy,
            strengths=strengths or [],
            weaknesses=weaknesses or [],
            trigger_conditions=trigger_conditions or [],
            ideal_tasks=ideal_tasks or [],
            peak_start_time=energy_cfg.get("peak_start"),
            peak_end_time=energy_cfg.get("peak_end"),
            trough_start_time=energy_cfg.get("trough_start"),
            trough_end_time=energy_cfg.get("trough_end"),
            recovery_start_time=energy_cfg.get("recovery_start"),
            recovery_end_time=energy_cfg.get("recovery_end"),
            ideal_weekly_hours=ideal_weekly_hours,
            actual_weekly_hours=0.0,
            is_active=True
        )
        
        return persona


def generate_personas_from_survey(
    user_id: str,
    survey_responses: Dict[str, Any]
) -> List[Persona]:
    """
    Convenience function to generate personas from survey.
    
    Args:
        user_id: User ID these personas belong to
        survey_responses: Complete survey response dictionary
        
    Returns:
        List of configured Persona objects
    """
    generator = PersonaGenerator(user_id)
    return generator.generate_personas_from_survey(survey_responses)
