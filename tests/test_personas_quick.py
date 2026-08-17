"""
Quick smoke test for persona module.

Tests basic functionality to ensure the module works before
integrating with API and database layers.

Following ClineRules #04: pytest with "3 line" test pattern where possible.
"""

import pytest
from datetime import time

from src.core.personas import (
    Persona,
    PersonaArchetype,
    EnergyReading,
    PersonaGenerator,
    generate_personas_from_survey,
    ARCHETYPE_TEMPLATES,
)
from src.core.personas.survey_config import get_question_by_id


class TestPersonaModels:
    """Test persona data models."""
    
    def test_persona_creation(self):
        """Test creating a persona with basic attributes."""
        # Arrange & Act
        persona = Persona(
            user_id="test-user",
            name="Test Persona",
            emoji="🧪",
            archetype=PersonaArchetype.PROFESSIONAL
        )
        # Assert
        assert persona.name == "Test Persona"
        assert persona.user_id == "test-user"
        assert persona.archetype == PersonaArchetype.PROFESSIONAL
    
    def test_energy_level_at_peak(self):
        """Test energy calculation during peak hours."""
        # Arrange
        persona = Persona(
            user_id="test-user",
            name="Morning Person",
            peak_start_time=time(9, 0),
            peak_end_time=time(12, 0)
        )
        # Act
        energy = persona.get_energy_level(time(10, 0))
        # Assert
        assert energy == 10  # Peak energy
    
    def test_energy_level_at_trough(self):
        """Test energy calculation during trough period."""
        # Arrange
        persona = Persona(
            user_id="test-user",
            name="Afternoon Dipper",
            trough_start_time=time(14, 0),
            trough_end_time=time(16, 0)
        )
        # Act
        energy = persona.get_energy_level(time(15, 0))
        # Assert
        assert energy == 3  # Trough energy
    
    def test_balance_score_optimal(self):
        """Test balance score when persona getting ideal hours."""
        # Arrange
        persona = Persona(
            user_id="test-user",
            name="Balanced",
            ideal_weekly_hours=40.0,
            actual_weekly_hours=40.0
        )
        # Act
        score = persona.calculate_balance_score()
        # Assert
        assert score == 1.0  # Perfect balance
    
    def test_balance_score_underserved(self):
        """Test balance score when persona is neglected."""
        # Arrange
        persona = Persona(
            user_id="test-user",
            name="Neglected",
            ideal_weekly_hours=40.0,
            actual_weekly_hours=10.0
        )
        # Act
        score = persona.calculate_balance_score()
        # Assert
        assert score == 0.25  # 10/40 = 0.25


class TestEnergyReading:
    """Test energy reading model."""
    
    def test_energy_reading_creation(self):
        """Test creating an energy reading."""
        # Arrange & Act
        reading = EnergyReading(
            persona_id="persona-123",
            energy_level=7,
            confidence=0.8,
            source="manual"
        )
        # Assert
        assert reading.energy_level == 7
        assert reading.confidence == 0.8
    
    def test_energy_reading_validation(self):
        """Test energy reading validates ranges."""
        # Arrange & Act & Assert
        with pytest.raises(ValueError):
            EnergyReading(
                persona_id="test",
                energy_level=11,  # Invalid: must be 1-10
                confidence=0.5
            )


class TestPersonaGenerator:
    """Test persona generation from survey responses."""
    
    def test_generate_from_survey_basic(self):
        """Test generating personas from survey responses."""
        # Arrange
        responses = {
            "archetypes_selection": [
                "🧠 The Professional - Responsible, structured, goal-focused"
            ],
            "overall_energy_pattern": "Mid-morning (9am-12pm)",
        }
        # Act
        personas = generate_personas_from_survey("test-user", responses)
        # Assert
        assert len(personas) == 1
        assert personas[0].archetype == PersonaArchetype.PROFESSIONAL
        assert personas[0].user_id == "test-user"
    
    def test_generate_with_custom_name(self):
        """Test persona generation with custom names."""
        # Arrange
        generator = PersonaGenerator("test-user")
        responses = {
            "archetypes_selection": [
                "🎨 The Artist - Expressive, introspective, imaginative"
            ],
            "custom_persona_names": "Creative Chris",
            "overall_energy_pattern": "Early evening (6pm-8pm) - After-work hours",
        }
        # Act
        personas = generator.generate_personas_from_survey(responses)
        # Assert
        assert personas[0].name == "Creative Chris"
        assert personas[0].emoji == "🎨"
    
    def test_energy_pattern_extraction(self):
        """Test energy pattern extraction from survey."""
        # Arrange
        generator = PersonaGenerator("test-user")
        responses = {
            "overall_energy_pattern": "Early morning (7am-9am) - Pre-business hours",
            "energy_dip": "Yes, I notice a definite slump",
            "energy_dip_time": "Mid-afternoon (2pm-4pm)"
        }
        # Act
        energy_config = generator._extract_energy_config(responses)
        # Assert
        assert energy_config["peak_start"] == time(7, 0)
        assert energy_config["peak_end"] == time(9, 0)
        assert energy_config["trough_start"] == time(14, 0)
        assert energy_config["trough_end"] == time(16, 0)

    # Expected (peak_start, peak_end) for each real survey option. The two
    # "no single peak" options map to (None, None) by design.
    _EXPECTED_PEAKS = {
        "(5am-7am)": (time(5, 0), time(7, 0)),
        "(7am-9am)": (time(7, 0), time(9, 0)),
        "(9am-12pm)": (time(9, 0), time(12, 0)),
        "(12pm-3pm)": (time(12, 0), time(15, 0)),
        "(3pm-6pm)": (time(15, 0), time(18, 0)),
        "(6pm-8pm)": (time(18, 0), time(20, 0)),
        "(8pm-11pm)": (time(20, 0), time(23, 0)),
        "(11pm-2am)": (time(23, 0), time(2, 0)),
    }

    @pytest.mark.parametrize(
        "option", get_question_by_id("overall_energy_pattern").options
    )
    def test_every_energy_option_maps(self, option):
        """Regression guard: every survey peak option maps to its expected times.

        Prevents drift between survey_config options and the generator's
        parser (the mismatch that silently broke half the options).
        """
        # Arrange
        generator = PersonaGenerator("test-user")
        expected = next(
            (times for token, times in self._EXPECTED_PEAKS.items() if token in option),
            (None, None),  # "It varies" / "multiple peaks" have no single peak
        )
        # Act
        config = generator._extract_energy_config({"overall_energy_pattern": option})
        # Assert
        assert (config["peak_start"], config["peak_end"]) == expected

    @pytest.mark.parametrize(
        "option", get_question_by_id("energy_dip_time").options
    )
    def test_every_dip_option_maps(self, option):
        """Regression guard: every dip-time option maps to a trough (or None for 'Other')."""
        # Arrange
        generator = PersonaGenerator("test-user")
        responses = {"energy_dip": "Yes, I notice a definite slump", "energy_dip_time": option}
        # Act
        config = generator._extract_energy_config(responses)
        # Assert: only "Other time" leaves the trough unset
        assert (config["trough_start"] is None) == ("Other" in option)

    def test_time_allocation_parsing(self):
        """Test parsing weekly time allocation."""
        # Arrange
        generator = PersonaGenerator("test-user")
        text = "Work: 40hrs, Creative: 5hrs, Family: 15"
        # Act
        allocation = generator._parse_time_allocation(text)
        # Assert
        assert allocation["Work"] == 40.0
        assert allocation["Creative"] == 5.0
        assert allocation["Family"] == 15.0


class TestArchetypeTemplates:
    """Test archetype templates are properly configured."""
    
    def test_all_archetypes_have_templates(self):
        """Test that all archetypes (except CUSTOM) have templates."""
        # Arrange
        expected_archetypes = [
            PersonaArchetype.PROFESSIONAL,
            PersonaArchetype.INNER_CHILD,
            PersonaArchetype.ARTIST,
            PersonaArchetype.BUILDER,
            PersonaArchetype.GUARDIAN,
            PersonaArchetype.ARCHITECT,
            PersonaArchetype.HISTORIAN,
            PersonaArchetype.OPTIMIZER,
        ]
        # Act & Assert
        for archetype in expected_archetypes:
            assert archetype in ARCHETYPE_TEMPLATES
            template = ARCHETYPE_TEMPLATES[archetype]
            assert template.default_name
            assert template.emoji
            assert template.primary_energy
    
    def test_professional_template(self):
        """Test Professional archetype template has correct attributes."""
        # Arrange & Act
        template = ARCHETYPE_TEMPLATES[PersonaArchetype.PROFESSIONAL]
        # Assert
        assert template.emoji == "🧠"
        assert template.default_name == "The Professional"
        assert len(template.common_strengths) > 0
        assert len(template.common_weaknesses) > 0
        assert template.typical_peak_start == time(7, 0)


# Gist test - tests complete flow
class TestCompletePersonaFlow:
    """Gist test: Complete persona creation flow."""
    
    def test_complete_onboarding_flow(self):
        """
        Test: User completes survey → Personas generated → Energy patterns set
        
        This is a "gist test" - tests as much functionality as possible
        in one comprehensive test to ensure the system works end-to-end.
        """
        # Arrange: Simulated survey responses
        survey_responses = {
            "archetypes_selection": [
                "🧠 The Professional - Responsible, structured, goal-focused",
                "🎨 The Artist - Expressive, introspective, imaginative"
            ],
            "custom_persona_names": "Executive Emma, Creative Chris",
            "overall_energy_pattern": "Mid-morning (9am-12pm)",
            "energy_dip": "Yes, I notice a definite slump",
            "energy_dip_time": "Early afternoon (12pm-2pm)",
            "weekly_time_allocation": "Work: 40hrs, Creative: 10hrs"
        }
        
        # Act: Generate personas
        personas = generate_personas_from_survey("user-123", survey_responses)
        
        # Assert: Verify complete setup
        assert len(personas) == 2, "Should create 2 personas"
        
        # Check first persona (Professional)
        emma = personas[0]
        assert emma.name == "Executive Emma"
        assert emma.emoji == "🧠"
        assert emma.archetype == PersonaArchetype.PROFESSIONAL
        assert emma.user_id == "user-123"
        assert emma.ideal_weekly_hours == 40.0
        
        # Check energy patterns set correctly
        assert emma.peak_start_time == time(9, 0)
        assert emma.peak_end_time == time(12, 0)
        assert emma.trough_start_time == time(12, 0)
        assert emma.trough_end_time == time(14, 0)
        
        # Check energy calculation works
        assert emma.get_energy_level(time(10, 0)) == 10  # Peak
        assert emma.get_energy_level(time(13, 0)) == 3   # Trough
        
        # Check second persona (Artist)
        chris = personas[1]
        assert chris.name == "Creative Chris"
        assert chris.emoji == "🎨"
        assert chris.ideal_weekly_hours == 10.0
        
        # Check balance scoring works
        emma.actual_weekly_hours = 40.0
        assert emma.calculate_balance_score() == 1.0  # Perfectly balanced
        
        chris.actual_weekly_hours = 2.0
        assert chris.calculate_balance_score() == 0.2  # Underserved (2/10)
        
        print("✅ Complete onboarding flow test PASSED")
        print(f"   - Created {len(personas)} personas")
        print(f"   - {emma.name}: {emma.archetype.value}, {emma.ideal_weekly_hours}hrs/week")
        print(f"   - {chris.name}: {chris.archetype.value}, {chris.ideal_weekly_hours}hrs/week")
        print(f"   - Energy patterns configured correctly")
        print(f"   - Balance scoring working")
