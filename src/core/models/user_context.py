"""
User Context Models for Adaptive Personalization.

Stores learned patterns, preferences, and statistics about user behavior.
"""

from dataclasses import dataclass, field
from datetime import datetime, timedelta
from typing import Dict, List, Optional, Any
from enum import Enum


class ContextType(str, Enum):
    """Types of user context"""
    PREFERENCE = "preference"
    PATTERN = "pattern"
    STAT = "stat"
    PERSONA_AFFINITY = "persona_affinity"


class LearnedFrom(str, Enum):
    """Source of learned context"""
    EXPLICIT = "explicit"  # User directly provided
    FEEDBACK = "feedback"  # Learned from user feedback
    PATTERN = "pattern"  # Detected from behavior patterns


@dataclass
class UserContext:
    """
    Stores learned user patterns and preferences.
    
    This is the core of Phase 1 personalization - simple, effective,
    and fast to implement.
    """
    
    user_id: str
    preferences: Dict[str, Any] = field(default_factory=dict)
    patterns: List[str] = field(default_factory=list)
    stats: Dict[str, float] = field(default_factory=dict)
    persona_affinities: Dict[str, float] = field(default_factory=dict)
    
    def to_prompt_context(self) -> str:
        """
        Convert to text for LLM prompt.
        
        This is how we achieve personalization in Phase 1 - by dynamically
        constructing prompts with user-specific context.
        """
        return f"""
User Profile:
- Work Style: {self.preferences.get('work_style', 'Not specified')}
- Peak Energy Hours: {self._format_hours(self.preferences.get('peak_energy_hours', []))}
- Communication Preference: {self.preferences.get('communication_preferences', 'Not specified')}

Learned Behavioral Patterns:
{self._format_patterns()}

Task Completion Statistics:
- Average Duration: {self.stats.get('avg_duration', 'Unknown')}
- Success Rate: {self.stats.get('success_rate', 0.0):.0%}
- Preferred Task Types: {', '.join(self.stats.get('preferred_types', ['None']))}
"""
    
    def _format_hours(self, hours: List[int]) -> str:
        """Format peak hours list"""
        if not hours:
            return "Not specified"
        return ", ".join([f"{h:02d}:00" for h in sorted(hours)])
    
    def _format_patterns(self) -> str:
        """Format patterns as bullet points"""
        if not self.patterns:
            return "- No patterns detected yet"
        return "\n".join([f"- {p}" for p in self.patterns])
    
    def to_dict(self) -> Dict[str, Any]:
        """Convert to dictionary for serialization"""
        return {
            "user_id": self.user_id,
            "preferences": self.preferences,
            "patterns": self.patterns,
            "stats": self.stats,
            "persona_affinities": self.persona_affinities,
        }
    
    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> "UserContext":
        """Create from dictionary"""
        return cls(
            user_id=data["user_id"],
            preferences=data.get("preferences", {}),
            patterns=data.get("patterns", []),
            stats=data.get("stats", {}),
            persona_affinities=data.get("persona_affinities", {}),
        )


@dataclass
class ContextItem:
    """Individual context item stored in database"""
    
    id: Optional[str]
    user_id: str
    context_type: ContextType
    key: str
    value: Any
    confidence: float = 1.0
    weight: float = 1.0  # Time-decay weight
    learned_from: LearnedFrom = LearnedFrom.PATTERN
    created_at: datetime = field(default_factory=datetime.utcnow)
    updated_at: datetime = field(default_factory=datetime.utcnow)
    last_accessed: datetime = field(default_factory=datetime.utcnow)
    
    def apply_time_decay(self) -> None:
        """
        Apply time-based decay weighting.
        
        Recent context is more relevant than old context, but we never
        completely discard old patterns (they might resurface).
        """
        now = datetime.utcnow()
        age_days = (now - self.created_at).days
        
        if age_days <= 7:
            self.weight = 1.0  # Last week: full weight
        elif age_days <= 30:
            self.weight = 0.7  # Last month: 70% weight
        elif age_days <= 90:
            self.weight = 0.4  # Last 3 months: 40% weight
        else:
            self.weight = 0.2  # Older: 20% weight (never zero)
    
    def to_dict(self) -> Dict[str, Any]:
        """Convert to dictionary for database storage"""
        return {
            "id": self.id,
            "user_id": self.user_id,
            "context_type": self.context_type.value,
            "key": self.key,
            "value": self.value,
            "confidence": self.confidence,
            "weight": self.weight,
            "learned_from": self.learned_from.value,
            "created_at": self.created_at.isoformat(),
            "updated_at": self.updated_at.isoformat(),
            "last_accessed": self.last_accessed.isoformat(),
        }


@dataclass
class UserFeedback:
    """
    Stores user feedback for continuous learning.
    
    This is how the system improves over time - by learning from
    what the user accepts or rejects.
    """
    
    id: Optional[str]
    user_id: str
    interaction_type: str  # 'task_suggestion', 'persona_detection', etc.
    interaction_data: Dict[str, Any]
    feedback_type: str  # 'accepted', 'rejected', 'modified'
    feedback_data: Dict[str, Any]
    created_at: datetime = field(default_factory=datetime.utcnow)
    
    def to_dict(self) -> Dict[str, Any]:
        """Convert to dictionary for database storage"""
        return {
            "id": self.id,
            "user_id": self.user_id,
            "interaction_type": self.interaction_type,
            "interaction_data": self.interaction_data,
            "feedback_type": self.feedback_type,
            "feedback_data": self.feedback_data,
            "created_at": self.created_at.isoformat(),
        }


def calculate_context_relevance(
    context_item: ContextItem,
    current_time: datetime,
    current_context: Optional[Dict[str, Any]] = None
) -> float:
    """
    Calculate how relevant a context item is right now.
    
    Factors:
    - Time decay (older = less relevant)
    - Confidence score
    - Contextual match (if provided)
    
    Returns:
        Relevance score 0.0 to 1.0
    """
    # Base: time-decayed weight and confidence
    base_relevance = context_item.weight * context_item.confidence
    
    # Boost if context matches current situation
    if current_context and "time_of_day" in current_context:
        # Example: boost work-related patterns during work hours
        if "work" in context_item.key.lower():
            hour = current_context["time_of_day"]
            if 9 <= hour <= 17:  # Work hours
                base_relevance *= 1.2
    
    # Cap at 1.0
    return min(1.0, base_relevance)
