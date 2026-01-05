"""
Onboarding survey configuration for Multitudes v2.0.

Defines the 5-phase survey flow for discovering and configuring user personas.
Based on research-backed personality assessment and energy patterns.

Following ClineRules:
- Rule #03: Type hints, clear structure
- Rule #05: Domain-driven survey design
- Rule #14: Well-documented configuration
"""

from typing import List, Dict, Any, Optional
from dataclasses import dataclass
from .persona_models import PersonaArchetype, ARCHETYPE_TEMPLATES


@dataclass
class SurveyQuestion:
    """A single survey question with options and metadata."""
    id: str
    text: str
    question_type: str  # "single_choice", "multiple_choice", "text", "slider", "time_range"
    options: Optional[List[str]] = None
    help_text: Optional[str] = None
    placeholder: Optional[str] = None
    required: bool = False
    default_value: Optional[Any] = None


@dataclass
class SurveyPhase:
    """A phase in the onboarding survey."""
    id: str
    title: str
    description: str
    time_estimate: str  # e.g., "3-4 minutes"
    questions: List[SurveyQuestion]
    icon: str = "✨"


# Phase 1: Discovering Your Multitudes
PHASE_1_DISCOVER = SurveyPhase(
    id="discover",
    title="Discovering Your Multitudes",
    description="We all contain multitudes - different aspects of who we are. Let's identify yours.",
    time_estimate="3-4 minutes",
    icon="🎭",
    questions=[
        SurveyQuestion(
            id="archetypes_selection",
            text="Which of these personas resonate with you?",
            question_type="multiple_choice",
            help_text="Select all that apply. You can customize them later!",
            options=[
                f"{template.emoji} {template.default_name} - {template.primary_energy}"
                for template in ARCHETYPE_TEMPLATES.values()
            ] + ["✨ I'll create my own"],
            required=True
        ),
        SurveyQuestion(
            id="custom_persona_names",
            text="Let's personalize your personas. Give them names that feel right to you.",
            question_type="text",
            help_text="Examples: 'Executive Emma', 'The Artist', 'Dad Mode'. Keep default names if you like them!",
            placeholder="Enter custom names (optional)"
        ),
        SurveyQuestion(
            id="neglected_personas",
            text="Which parts of yourself feel most neglected right now?",
            question_type="multiple_choice",
            help_text="This helps us understand where to focus first.",
            options=[
                "Creative/artistic side",
                "Professional/work self",
                "Playful/spontaneous side",
                "Organized/systematic side",
                "Caring/nurturing side",
                "Analytical/problem-solving side",
                "Physical/hands-on side",
                "Reflective/introspective side"
            ]
        )
    ]
)

# Phase 2: Energy Mapping
PHASE_2_ENERGY = SurveyPhase(
    id="energy",
    title="Understanding Your Energy Rhythms",
    description="Each persona has different energy patterns. Let's map when each feels most alive.",
    time_estimate="3 minutes",
    icon="⚡",
    questions=[
        SurveyQuestion(
            id="overall_energy_pattern",
            text="When do you typically feel most energized for focused work?",
            question_type="single_choice",
            options=[
                "Very early morning (5am-7am) - Dawn hours",
                "Early morning (7am-9am) - Pre-business hours",
                "Mid-morning (9am-12pm) - Standard productivity hours",
                "Early afternoon (12pm-3pm) - Post-lunch energy",
                "Late afternoon (3pm-6pm) - End-of-day surge",
                "Early evening (6pm-8pm) - After-work hours",
                "Late evening (8pm-11pm) - Night owl mode",
                "Very late night (11pm-2am) - Deep night focus",
                "It varies significantly by day/season",
                "I have multiple peak periods per day"
            ],
            required=True
        ),
        SurveyQuestion(
            id="energy_dip",
            text="Is there a time when your energy naturally dips?",
            question_type="single_choice",
            options=[
                "Yes, I notice a definite slump",
                "Sometimes, but it's not consistent",
                "Not really, I'm pretty steady",
                "I can power through with coffee/breaks"
            ]
        ),
        SurveyQuestion(
            id="energy_dip_time",
            text="When does your energy typically dip?",
            question_type="single_choice",
            options=[
                "Late morning (10am-12pm)",
                "Early afternoon (12pm-2pm)",
                "Mid-afternoon (2pm-4pm)",
                "Early evening (5pm-7pm)",
                "Other time"
            ],
            help_text="This is your 'trough' period - we'll help you schedule lighter tasks then."
        ),
        SurveyQuestion(
            id="recovery_strategies",
            text="When you hit that low-energy point, what helps you bounce back?",
            question_type="multiple_choice",
            options=[
                "A short break or walk",
                "Coffee or snack",
                "Switch to lighter tasks",
                "Social interaction",
                "Physical activity",
                "Power nap (10-20 min)",
                "Just push through it",
                "Other"
            ]
        )
    ]
)

# Phase 3: Task Alignment
PHASE_3_TASKS = SurveyPhase(
    id="tasks",
    title="Matching Tasks to Personas",
    description="Different personas handle different types of work. Let's figure out who does what.",
    time_estimate="2-3 minutes",
    icon="📋",
    questions=[
        SurveyQuestion(
            id="task_by_time",
            text="What types of work do you find yourself most drawn to during your peak energy periods?",
            question_type="multiple_choice",
            help_text="Select all that apply. We'll help you align tasks with your natural energy rhythms.",
            options=[
                "Deep analytical/logical work (coding, data analysis, problem-solving)",
                "Creative/artistic projects (writing, design, music, ideation)",
                "Strategic thinking and planning (architecture, system design, roadmaps)",
                "Learning and skill development (courses, reading, research)",
                "Communication and collaboration (meetings, presentations, mentoring)",
                "Administrative tasks (email, scheduling, documentation)",
                "Physical/hands-on work (building, repairs, crafts)",
                "Reflective work (journaling, reviewing, organizing thoughts)",
                "Social/relationship work (networking, team building, personal connections)"
            ]
        ),
        SurveyQuestion(
            id="low_energy_preferences", 
            text="What do you prefer to do during your low-energy periods?",
            question_type="multiple_choice",
            help_text="These are good 'trough period' activities that don't require peak focus.",
            options=[
                "Light administrative tasks (filing, organizing, simple emails)",
                "Routine maintenance (cleaning, updating systems, backups)",
                "Consuming content (reading articles, watching tutorials)",
                "Social activities (casual conversations, checking in with people)", 
                "Physical tasks that don't require deep thinking",
                "Rest and recovery (breaks, walks, meditation)",
                "Creative play (doodling, light brainstorming, free writing)",
                "I prefer to just rest during low-energy times"
            ]
        ),
        SurveyQuestion(
            id="weekly_time_allocation",
            text="Roughly how many hours per week do you want each major area to get?",
            question_type="text",
            help_text="This helps us track if your personas are balanced. Examples: Work: 40hrs, Creative: 5hrs, Family: 15hrs",
            placeholder="Estimate hours for your main personas"
        ),
        SurveyQuestion(
            id="task_switching",
            text="How do you feel about switching between different types of work?",
            question_type="single_choice",
            options=[
                "I prefer focused blocks - one type of work at a time",
                "I like variety - switching keeps me engaged",
                "Depends on the day and my energy",
                "I struggle with transitions between tasks"
            ]
        )
    ]
)

# Phase 4: Balance Goals
PHASE_4_GOALS = SurveyPhase(
    id="goals",
    title="Your Balance Intentions",
    description="What would 'balanced multitudes' look like for you?",
    time_estimate="2 minutes",
    icon="⚖️",
    questions=[
        SurveyQuestion(
            id="current_imbalance",
            text="Which persona tends to dominate your life right now?",
            question_type="single_choice",
            options=[
                "Work/Professional (taking over everything)",
                "Caretaker/Family (no time for self)",
                "Perfectionist/Organizer (analysis paralysis)",
                "Creative/Dreamer (all ideas, no execution)",
                "Protector/Worrier (too much anxiety)",
                "None dominate - I feel pretty balanced",
                "Other"
            ]
        ),
        SurveyQuestion(
            id="thirty_day_intention",
            text="What would success look like 30 days from now?",
            question_type="text",
            placeholder="Example: 'More time for creative projects', 'Better work-life boundaries', 'Consistent self-care'",
            help_text="Optional, but helps us customize your experience."
        ),
        SurveyQuestion(
            id="biggest_challenge",
            text="What's your biggest challenge with balancing your multitudes?",
            question_type="single_choice",
            options=[
                "One persona always takes over",
                "I feel guilty prioritizing certain personas",
                "I lose track of which persona I'm in",
                "Transitions between personas are hard",
                "I don't even know what balance would look like",
                "Other"
            ]
        )
    ]
)

# Phase 5: Activation & Preferences
PHASE_5_ACTIVATION = SurveyPhase(
    id="activation",
    title="Bringing It To Life",
    description="Final touches - how should Multitudes support your personas?",
    time_estimate="1-2 minutes",
    icon="🚀",
    questions=[
        SurveyQuestion(
            id="reminder_style",
            text="How should we remind you to switch personas or check energy?",
            question_type="single_choice",
            options=[
                "Gentle nudges - occasional reminders",
                "Calendar blocks - schedule persona time",
                "Daily check-ins - morning and evening",
                "Just show me the dashboard - I'll check myself",
                "I'll figure it out as I go"
            ],
            required=True
        ),
        SurveyQuestion(
            id="tracking_preference",
            text="How much detail do you want to track?",
            question_type="single_choice",
            options=[
                "Comprehensive - track everything (energy, tasks, time)",
                "Balanced - key metrics only",
                "Minimal - just high-level balance",
                "I'll decide as I use it"
            ]
        ),
        SurveyQuestion(
            id="privacy_comfort",
            text="All data stays private on your device. In the future, would you consider:",
            question_type="multiple_choice",
            options=[
                "Cloud sync across my devices",
                "Anonymized insights to improve the system",
                "Sharing patterns with trusted friends/family",
                "Keep everything 100% local (current default)"
            ],
            help_text="This is just for future planning - everything is local-only for now."
        )
    ]
)

# Complete survey configuration
ONBOARDING_SURVEY = {
    "title": "Welcome to Multitudes",
    "subtitle": "Let's discover the multitudes within you",
    "total_time_estimate": "10-12 minutes",
    "phases": [
        PHASE_1_DISCOVER,
        PHASE_2_ENERGY,
        PHASE_3_TASKS,
        PHASE_4_GOALS,
        PHASE_5_ACTIVATION
    ]
}


def get_survey_config() -> Dict[str, Any]:
    """
    Get the complete onboarding survey configuration.
    
    Returns:
        Dictionary containing all survey phases and metadata
    """
    return ONBOARDING_SURVEY


def get_phase_by_id(phase_id: str) -> Optional[SurveyPhase]:
    """
    Get a specific survey phase by ID.
    
    Args:
        phase_id: The phase identifier (e.g., "discover", "energy")
        
    Returns:
        SurveyPhase if found, None otherwise
    """
    for phase in ONBOARDING_SURVEY["phases"]:
        if phase.id == phase_id:
            return phase
    return None


def get_question_by_id(question_id: str) -> Optional[SurveyQuestion]:
    """
    Get a specific question by ID across all phases.
    
    Args:
        question_id: The question identifier
        
    Returns:
        SurveyQuestion if found, None otherwise
    """
    for phase in ONBOARDING_SURVEY["phases"]:
        for question in phase.questions:
            if question.id == question_id:
                return question
    return None
