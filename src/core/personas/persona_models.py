"""
Core persona data models for Multitudes v2.0.

Defines the fundamental persona structures inspired by the original Multitudes v1
concept and enhanced with research-backed energy patterns.

Following ClineRules:
- Rule #03: Type hints throughout, dataclasses over dicts
- Rule #05: Domain-driven design with clear business concepts
- Rule #02: Single responsibility principle
"""

from dataclasses import dataclass, field
from datetime import datetime, time
from typing import List, Dict, Optional
from enum import Enum
from uuid import uuid4


class PersonaArchetype(str, Enum):
    """
    Common persona archetypes based on Multitudes v1 observations.
    
    These provide starting templates but users can fully customize.
    """
    PROFESSIONAL = "professional"  # 🧠 Work, responsibility, deadlines
    INNER_CHILD = "inner_child"    # 🌈 Play, emotion, connection
    ARTIST = "artist"              # 🎨 Creation, expression, beauty
    BUILDER = "builder"            # 🛠 Hands-on, fixing, making
    GUARDIAN = "guardian"          # 🛡 Protection, caution, safety
    ARCHITECT = "architect"        # 📐 Systems, order, planning
    HISTORIAN = "historian"        # 🗃 Memory, documentation, reflection
    OPTIMIZER = "optimizer"        # 🤖 Efficiency, automation, precision
    CUSTOM = "custom"              # ✨ User-defined


class TriggerCondition(str, Enum):
    """
    What activates a persona - time, context, environment, or stimulus.
    """
    # Time-based
    MORNING = "morning"
    AFTERNOON = "afternoon"
    EVENING = "evening"
    NIGHT = "night"
    WEEKDAY = "weekday"
    WEEKEND = "weekend"
    
    # Context-based
    ALONE = "alone"
    WITH_OTHERS = "with_others"
    UNDER_DEADLINE = "under_deadline"
    
    # Environment
    HOME = "home"
    OFFICE = "office"
    NATURE = "nature"
    TRAVEL = "travel"
    
    # Stimulus
    MUSIC = "music"
    CAFFEINE = "caffeine"
    EXERCISE = "exercise"
    MEDITATION = "meditation"
    CREATIVE_SPACE = "creative_space"


@dataclass
class Persona:
    """
    A persona represents one aspect of a user's multitudes.
    
    Each persona has unique energy patterns, strengths, weaknesses,
    and is suited for specific types of tasks.
    
    Based on the Multitudes v1 template:
    - Name (e.g., "Executive Emma", "The Artist")
    - Primary Energy (core behavioral traits)
    - Strengths (what they excel at)
    - Weaknesses (what drains them)
    - Trigger Conditions (what activates them)
    - Ideal Tasks (what they should handle)
    
    Enhanced with Peak-Trough-Recovery energy patterns.
    """
    # Identity
    id: str = field(default_factory=lambda: str(uuid4()))
    user_id: str = ""
    name: str = ""  # e.g., "Executive Emma", "The Artist"
    emoji: str = "✨"  # Visual identifier
    archetype: PersonaArchetype = PersonaArchetype.CUSTOM
    
    # Core characteristics (from v1 template)
    primary_energy: str = ""  # e.g., "Responsible, structured, goal-focused"
    strengths: List[str] = field(default_factory=list)
    weaknesses: List[str] = field(default_factory=list)
    trigger_conditions: List[str] = field(default_factory=list)
    ideal_tasks: List[str] = field(default_factory=list)
    
    # Energy patterns (Peak-Trough-Recovery model)
    peak_start_time: Optional[time] = None  # When peak energy begins
    peak_end_time: Optional[time] = None    # When peak energy ends
    trough_start_time: Optional[time] = None
    trough_end_time: Optional[time] = None
    recovery_start_time: Optional[time] = None
    recovery_end_time: Optional[time] = None
    
    # Balance tracking
    ideal_weekly_hours: float = 0.0  # How much time persona needs per week
    actual_weekly_hours: float = 0.0  # How much time persona is getting
    
    # Metadata
    created_at: datetime = field(default_factory=datetime.utcnow)
    updated_at: datetime = field(default_factory=datetime.utcnow)
    last_active: Optional[datetime] = None
    is_active: bool = True
    
    def calculate_balance_score(self) -> float:
        """
        Calculate how well-balanced this persona is (0.0 to 1.0).
        
        Returns:
            1.0 = optimal (getting ideal hours)
            0.5 = neutral (no data or balanced)
            0.0 = severely neglected or overworked
        """
        if self.ideal_weekly_hours == 0:
            return 0.5  # No preference set
        
        ratio = self.actual_weekly_hours / self.ideal_weekly_hours
        
        # Ideal ratio is 1.0, penalize both under and over
        if ratio <= 1.0:
            return ratio  # Underserved: 0.0 to 1.0
        else:
            # Overworked: diminish score as ratio increases beyond 1.0
            return max(0.0, 2.0 - ratio)
    
    def is_currently_at_peak(self, current_time: time) -> bool:
        """Check if persona is currently in peak energy period."""
        if not self.peak_start_time or not self.peak_end_time:
            return False
        
        # Handle time ranges that cross midnight
        if self.peak_start_time <= self.peak_end_time:
            return self.peak_start_time <= current_time <= self.peak_end_time
        else:
            return current_time >= self.peak_start_time or current_time <= self.peak_end_time
    
    def is_currently_at_trough(self, current_time: time) -> bool:
        """Check if persona is currently in trough (low energy) period."""
        if not self.trough_start_time or not self.trough_end_time:
            return False
        
        if self.trough_start_time <= self.trough_end_time:
            return self.trough_start_time <= current_time <= self.trough_end_time
        else:
            return current_time >= self.trough_start_time or current_time <= self.trough_end_time
    
    def get_energy_level(self, current_time: time) -> int:
        """
        Get predicted energy level (1-10) for this persona at given time.
        
        Args:
            current_time: Time to check energy for
            
        Returns:
            Energy level: 10 (peak), 3 (trough), 7 (recovery), 5 (neutral)
        """
        if self.is_currently_at_peak(current_time):
            return 10
        elif self.is_currently_at_trough(current_time):
            return 3
        elif self.recovery_start_time and self.recovery_end_time:
            if self.recovery_start_time <= self.recovery_end_time:
                if self.recovery_start_time <= current_time <= self.recovery_end_time:
                    return 7
            else:
                if current_time >= self.recovery_start_time or current_time <= self.recovery_end_time:
                    return 7
        
        return 5  # Neutral/unknown


@dataclass
class EnergyReading:
    """
    Time-series energy data point for a persona.
    
    Stored in InfluxDB for efficient time-series queries and analysis.
    Used to track actual energy levels over time and refine predictions.
    """
    # Identity
    id: str = field(default_factory=lambda: str(uuid4()))
    persona_id: str = ""
    
    # Measurement
    timestamp: datetime = field(default_factory=datetime.utcnow)
    energy_level: int = 5  # 1-10 scale
    confidence: float = 0.5  # 0.0-1.0, how confident we are in this reading
    
    # Source tracking
    source: str = "manual"  # manual, inferred, scheduled, feedback
    context: Dict[str, str] = field(default_factory=dict)  # Additional context
    
    # Metadata
    notes: Optional[str] = None  # User notes about this reading
    
    def __post_init__(self):
        """Validate energy reading data."""
        if not 1 <= self.energy_level <= 10:
            raise ValueError(f"Energy level must be 1-10, got {self.energy_level}")
        if not 0.0 <= self.confidence <= 1.0:
            raise ValueError(f"Confidence must be 0.0-1.0, got {self.confidence}")


@dataclass
class PersonaArchetypeTemplate:
    """
    Template for common persona archetypes to help users get started.
    
    Based on patterns observed in Multitudes v1 user personas.
    """
    archetype: PersonaArchetype
    default_name: str
    emoji: str
    primary_energy: str
    common_strengths: List[str]
    common_weaknesses: List[str]
    typical_triggers: List[str]
    ideal_task_categories: List[str]
    
    # Default energy patterns (can be customized)
    typical_peak_start: Optional[time] = None
    typical_peak_end: Optional[time] = None


# Predefined archetype templates
ARCHETYPE_TEMPLATES: Dict[PersonaArchetype, PersonaArchetypeTemplate] = {
    PersonaArchetype.PROFESSIONAL: PersonaArchetypeTemplate(
        archetype=PersonaArchetype.PROFESSIONAL,
        default_name="The Professional",
        emoji="🧠",
        primary_energy="Responsible, structured, goal-focused",
        common_strengths=[
            "Manages deadlines effectively",
            "Strong prioritization skills",
            "Excellent under time pressure",
            "Tracks open loops and executes cleanly"
        ],
        common_weaknesses=[
            "Easily overloaded by emotional ambiguity",
            "Can suppress personal needs",
            "Struggles with creative sprawl",
            "May burn out without boundaries"
        ],
        typical_triggers=["Weekday mornings", "Deadlines", "Meetings", "Email inbox"],
        ideal_task_categories=[
            "Administrative tasks",
            "Scheduling and planning",
            "Financial decisions",
            "High-stakes communication"
        ],
        typical_peak_start=time(7, 0),
        typical_peak_end=time(11, 0)
    ),
    
    PersonaArchetype.INNER_CHILD: PersonaArchetypeTemplate(
        archetype=PersonaArchetype.INNER_CHILD,
        default_name="The Little Kid",
        emoji="🌈",
        primary_energy="Emotional, playful, relational",
        common_strengths=[
            "Strong empathy and emotional intelligence",
            "Excellent at reading social cues",
            "Craves joy and authentic connection",
            "Great with unstructured play time"
        ],
        common_weaknesses=[
            "Sensitive to emotional overwhelm",
            "Avoids complex decision-making",
            "Easily derailed by negative emotions",
            "Struggles with sustained focus"
        ],
        typical_triggers=["Spontaneous messages", "Music", "Safe creative space", "Nature"],
        ideal_task_categories=[
            "Messaging loved ones",
            "Light journaling",
            "Aesthetic decisions",
            "Mood tracking and self-care"
        ],
        typical_peak_start=time(10, 0),
        typical_peak_end=time(14, 0)
    ),
    
    PersonaArchetype.ARTIST: PersonaArchetypeTemplate(
        archetype=PersonaArchetype.ARTIST,
        default_name="The Artist",
        emoji="🎨",
        primary_energy="Expressive, introspective, imaginative",
        common_strengths=[
            "Recharges through creative expression",
            "Connects ideas across domains",
            "Thrives in immersive flow states",
            "Values solitude and reflection"
        ],
        common_weaknesses=[
            "Prone to overcommitment",
            "Romanticizes unfinished work",
            "Dislikes administrative overhead",
            "Can get lost in perfectionism"
        ],
        typical_triggers=["Long drives", "Ambient music", "Open calendar blocks", "Nature walks"],
        ideal_task_categories=[
            "Creative writing",
            "Music and art",
            "Visual design",
            "System ideation"
        ],
        typical_peak_start=time(14, 0),
        typical_peak_end=time(18, 0)
    ),
    
    PersonaArchetype.BUILDER: PersonaArchetypeTemplate(
        archetype=PersonaArchetype.BUILDER,
        default_name="The Tinkerer",
        emoji="🛠",
        primary_energy="Physical, iterative, curious",
        common_strengths=[
            "Excellent with trial-and-error",
            "Builds solutions through hands-on work",
            "Thrives with tactile tools",
            "Natural problem-solver"
        ],
        common_weaknesses=[
            "Can get stuck refining without shipping",
            "Hates repetitive manual tasks",
            "May over-engineer solutions",
            "Struggles with abstract planning"
        ],
        typical_triggers=["New hardware", "Broken things", "Tools on table", "Physical workspace"],
        ideal_task_categories=[
            "Building and assembly",
            "Debugging and repairs",
            "Prototyping",
            "Equipment setup"
        ],
        typical_peak_start=time(9, 0),
        typical_peak_end=time(13, 0)
    ),
    
    PersonaArchetype.GUARDIAN: PersonaArchetypeTemplate(
        archetype=PersonaArchetype.GUARDIAN,
        default_name="The Protector",
        emoji="🛡",
        primary_energy="Defensive, vigilant, cautious",
        common_strengths=[
            "Excellent risk detection",
            "Strong threat prevention instincts",
            "Thinks through edge cases",
            "Values preparedness"
        ],
        common_weaknesses=[
            "Can be overly pessimistic",
            "May retreat from growth opportunities",
            "Avoids emotional vulnerability",
            "Paralysis by analysis"
        ],
        typical_triggers=["Missed sleep", "High-anxiety situations", "Upcoming travel", "Deadlines"],
        ideal_task_categories=[
            "Scenario planning",
            "Security audits",
            "Emergency preparation",
            "Risk assessment"
        ],
        typical_peak_start=time(6, 0),
        typical_peak_end=time(10, 0)
    ),
    
    PersonaArchetype.ARCHITECT: PersonaArchetypeTemplate(
        archetype=PersonaArchetype.ARCHITECT,
        default_name="The Organizer",
        emoji="📐",
        primary_energy="Configurational, orderly, systemic",
        common_strengths=[
            "Plans and optimizes effectively",
            "Excellent at workflow design",
            "Loves templates and structure",
            "Reshuffles priorities skillfully"
        ],
        common_weaknesses=[
            "Can lose sight of emotional needs",
            "Struggles with chaos or rapid pivots",
            "Over-optimizes at times",
            "May delay action for perfection"
        ],
        typical_triggers=["System breakdowns", "Clutter", "Big events coming", "Calendar chaos"],
        ideal_task_categories=[
            "Calendar planning",
            "File organization",
            "Infrastructure design",
            "Workflow optimization"
        ],
        typical_peak_start=time(8, 0),
        typical_peak_end=time(12, 0)
    ),
    
    PersonaArchetype.HISTORIAN: PersonaArchetypeTemplate(
        archetype=PersonaArchetype.HISTORIAN,
        default_name="The Archivist",
        emoji="🗃",
        primary_energy="Retrospective, curious, meticulous",
        common_strengths=[
            "Keeps excellent records",
            "Surfaces forgotten details",
            "Reconstructs timelines accurately",
            "Values completeness"
        ],
        common_weaknesses=[
            "May fixate on past data",
            "Can over-document",
            "Delays forward motion",
            "Perfectionist tendencies"
        ],
        typical_triggers=["End-of-week", "Tagging sessions", "Postmortems", "Review time"],
        ideal_task_categories=[
            "Documentation",
            "Summaries and reports",
            "Narrative logs",
            "Data archiving"
        ],
        typical_peak_start=time(15, 0),
        typical_peak_end=time(19, 0)
    ),
    
    PersonaArchetype.OPTIMIZER: PersonaArchetypeTemplate(
        archetype=PersonaArchetype.OPTIMIZER,
        default_name="The Assistant",
        emoji="🤖",
        primary_energy="Automation, precision, support-focused",
        common_strengths=[
            "Helps others work smarter",
            "Eliminates busywork efficiently",
            "Bridges systems together",
            "Delegates effectively"
        ],
        common_weaknesses=[
            "Doesn't initiate independently",
            "Relies on others for goals",
            "Frustrated by analog processes",
            "May over-automate"
        ],
        typical_triggers=["Repeat tasks", "Friction points", "File formatting", "Tool setup"],
        ideal_task_categories=[
            "Scripting and automation",
            "Data cleaning",
            "Tool integration",
            "Process optimization"
        ],
        typical_peak_start=time(13, 0),
        typical_peak_end=time(17, 0)
    ),
}
