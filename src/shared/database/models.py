"""
SQLAlchemy Database Models for Multitudes.

These models define the PostgreSQL schema for user context persistence.
"""

import uuid
from datetime import datetime
from typing import Optional

from sqlalchemy import (
    Column,
    String,
    Float,
    Integer,
    DateTime,
    Text,
    ForeignKey,
    Index,
    CheckConstraint,
    Boolean,
)
from sqlalchemy.dialects.postgresql import UUID, JSONB, ARRAY
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship

Base = declarative_base()


def generate_uuid():
    """Generate UUID for primary keys"""
    return str(uuid.uuid4())


class User(Base):
    """User table for multi-user support"""
    
    __tablename__ = "users"
    
    id = Column(String(32), primary_key=True, default=generate_uuid)
    email = Column(String(255), unique=True, nullable=True)
    display_name = Column(String(100), nullable=True)
    passphrase_hash = Column(String(255), nullable=True)  # For passphrase auth
    created_at = Column(DateTime, default=datetime.utcnow, nullable=False)
    last_login = Column(DateTime, nullable=True)
    is_active = Column(Boolean, default=True, nullable=False)
    
    # Relationships
    contexts = relationship("UserContextDB", back_populates="user", cascade="all, delete-orphan")
    feedback = relationship("UserFeedbackDB", back_populates="user", cascade="all, delete-orphan")
    personas = relationship("Persona", back_populates="user", cascade="all, delete-orphan")
    
    def __repr__(self):
        return f"<User(id={self.id}, email={self.email})>"


class UserContextDB(Base):
    """
    User context storage for adaptive personalization.
    
    Stores learned patterns, preferences, and statistics with time-decay weighting.
    """
    
    __tablename__ = "user_contexts"
    
    id = Column(String(32), primary_key=True, default=generate_uuid)
    user_id = Column(String(32), ForeignKey("users.id", ondelete="CASCADE"), nullable=False)
    context_type = Column(String(50), nullable=False)  # 'preference', 'pattern', 'stat', 'persona_affinity'
    key = Column(String(100), nullable=False)
    value = Column(JSONB, nullable=False)
    confidence = Column(Float, default=1.0, nullable=False)
    weight = Column(Float, default=1.0, nullable=False)  # Time-decay weight
    learned_from = Column(String(100), nullable=False)  # 'explicit', 'feedback', 'pattern'
    created_at = Column(DateTime, default=datetime.utcnow, nullable=False)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow, nullable=False)
    last_accessed = Column(DateTime, default=datetime.utcnow, nullable=False)
    
    # Relationships
    user = relationship("User", back_populates="contexts")
    
    # Indexes for performance
    __table_args__ = (
        Index("idx_user_contexts_user_type", "user_id", "context_type"),
        Index("idx_user_contexts_weight", "weight"),
        Index("idx_user_contexts_created", "created_at"),
        # Unique constraint on user_id + context_type + key
        Index("idx_user_contexts_unique", "user_id", "context_type", "key", unique=True),
        CheckConstraint("confidence >= 0 AND confidence <= 1", name="check_confidence_range"),
        CheckConstraint("weight >= 0 AND weight <= 1", name="check_weight_range"),
    )
    
    def __repr__(self):
        return f"<UserContextDB(id={self.id}, user_id={self.user_id}, type={self.context_type}, key={self.key})>"


class UserFeedbackDB(Base):
    """
    User feedback storage for continuous learning.
    
    Tracks user acceptance/rejection of AI suggestions to improve over time.
    """
    
    __tablename__ = "user_feedback"
    
    id = Column(String(32), primary_key=True, default=generate_uuid)
    user_id = Column(String(32), ForeignKey("users.id", ondelete="CASCADE"), nullable=False)
    interaction_type = Column(String(50), nullable=False)  # 'task_suggestion', 'persona_detection', etc.
    interaction_data = Column(JSONB, nullable=False)
    feedback_type = Column(String(50), nullable=False)  # 'accepted', 'rejected', 'modified'
    feedback_data = Column(JSONB, nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow, nullable=False)
    
    # Relationships
    user = relationship("User", back_populates="feedback")
    
    # Indexes
    __table_args__ = (
        Index("idx_feedback_user_time", "user_id", "created_at"),
        Index("idx_feedback_type", "interaction_type"),
    )
    
    def __repr__(self):
        return f"<UserFeedbackDB(id={self.id}, user_id={self.user_id}, type={self.feedback_type})>"


class Persona(Base):
    """
    Persona definitions for Multitudes system.
    
    Represents one aspect of a user's multitudes with unique energy patterns,
    strengths, weaknesses, and ideal tasks. Based on Multitudes v1 concept
    enhanced with Peak-Trough-Recovery energy model.
    """
    
    __tablename__ = "personas"
    
    # Identity
    id = Column(String(32), primary_key=True, default=generate_uuid)
    user_id = Column(String(32), ForeignKey("users.id", ondelete="CASCADE"), nullable=False)
    name = Column(String(100), nullable=False)
    emoji = Column(String(10), nullable=False, default="✨")
    archetype = Column(String(50), nullable=False)  # professional, artist, etc.
    
    # Core characteristics (from Multitudes v1 template)
    primary_energy = Column(Text, nullable=True)  # Core behavioral traits
    strengths = Column(ARRAY(String), nullable=True)
    weaknesses = Column(ARRAY(String), nullable=True)
    trigger_conditions = Column(ARRAY(String), nullable=True)
    ideal_tasks = Column(ARRAY(String), nullable=True)
    
    # Energy patterns (Peak-Trough-Recovery model) - stored as "HH:MM" strings
    peak_start_time = Column(String(5), nullable=True)  # e.g., "09:00"
    peak_end_time = Column(String(5), nullable=True)
    trough_start_time = Column(String(5), nullable=True)
    trough_end_time = Column(String(5), nullable=True)
    recovery_start_time = Column(String(5), nullable=True)
    recovery_end_time = Column(String(5), nullable=True)
    
    # Balance tracking
    ideal_weekly_hours = Column(Float, default=0.0, nullable=False)
    actual_weekly_hours = Column(Float, default=0.0, nullable=False)
    
    # Metadata
    created_at = Column(DateTime, default=datetime.utcnow, nullable=False)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow, nullable=False)
    last_active = Column(DateTime, nullable=True)
    is_active = Column(Boolean, default=True, nullable=False)
    
    # Relationships
    user = relationship("User", back_populates="personas")
    tasks = relationship("Task", back_populates="persona")
    energy_readings = relationship("EnergyReading", back_populates="persona", cascade="all, delete-orphan")
    
    # Indexes
    __table_args__ = (
        Index("idx_personas_user_active", "user_id", "is_active"),
        Index("idx_personas_archetype", "archetype"),
    )
    
    def __repr__(self):
        return f"<Persona(id={self.id}, name={self.name}, archetype={self.archetype})>"


class EnergyReading(Base):
    """
    Time-series energy readings for personas.
    
    Tracks actual energy levels over time to refine predictions.
    For high-volume time-series data, this could be moved to InfluxDB,
    but starting in PostgreSQL for simplicity.
    """
    
    __tablename__ = "energy_readings"
    
    id = Column(String(32), primary_key=True, default=generate_uuid)
    persona_id = Column(String(32), ForeignKey("personas.id", ondelete="CASCADE"), nullable=False)
    
    # Measurement
    timestamp = Column(DateTime, default=datetime.utcnow, nullable=False)
    energy_level = Column(Integer, nullable=False)  # 1-10 scale
    confidence = Column(Float, default=0.5, nullable=False)  # 0.0-1.0
    
    # Source tracking
    source = Column(String(50), default="manual", nullable=False)  # manual, inferred, scheduled, feedback
    context = Column(JSONB, nullable=True)  # Additional context
    notes = Column(Text, nullable=True)
    
    # Relationships
    persona = relationship("Persona", back_populates="energy_readings")
    
    # Indexes and constraints
    __table_args__ = (
        Index("idx_energy_readings_persona_time", "persona_id", "timestamp"),
        Index("idx_energy_readings_timestamp", "timestamp"),
        CheckConstraint("energy_level >= 1 AND energy_level <= 10", name="check_energy_level_range"),
        CheckConstraint("confidence >= 0.0 AND confidence <= 1.0", name="check_energy_confidence_range"),
    )
    
    def __repr__(self):
        return f"<EnergyReading(persona_id={self.persona_id}, timestamp={self.timestamp}, level={self.energy_level})>"


class Task(Base):
    """Task/Todo items"""
    
    __tablename__ = "tasks"
    
    id = Column(String(32), primary_key=True, default=generate_uuid)
    user_id = Column(String(32), ForeignKey("users.id", ondelete="CASCADE"), nullable=False)
    persona_id = Column(String(32), ForeignKey("personas.id", ondelete="SET NULL"), nullable=True)
    title = Column(String(500), nullable=False)
    description = Column(Text, nullable=True)
    priority = Column(Integer, nullable=True)
    energy_required = Column(Integer, nullable=True)
    estimated_duration = Column(Integer, nullable=True)  # minutes
    due_date = Column(DateTime, nullable=True)
    completed = Column(Boolean, default=False, nullable=False)
    completed_at = Column(DateTime, nullable=True)
    source = Column(String(50), nullable=True)  # 'email', 'calendar', 'manual'
    source_metadata = Column(JSONB, nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow, nullable=False)
    
    # Relationships
    persona = relationship("Persona", back_populates="tasks")
    
    # Constraints
    __table_args__ = (
        CheckConstraint("priority >= 1 AND priority <= 5", name="check_priority_range"),
        CheckConstraint("energy_required >= 1 AND energy_required <= 5", name="check_energy_range"),
        Index("idx_tasks_user_completed", "user_id", "completed"),
        Index("idx_tasks_due_date", "due_date"),
    )
    
    def __repr__(self):
        return f"<Task(id={self.id}, title={self.title[:30]})>"


class Insight(Base):
    """AI-generated insights"""
    
    __tablename__ = "insights"
    
    id = Column(String(32), primary_key=True, default=generate_uuid)
    user_id = Column(String(32), ForeignKey("users.id", ondelete="CASCADE"), nullable=False)
    persona_id = Column(String(32), ForeignKey("personas.id", ondelete="SET NULL"), nullable=True)
    type = Column(String(50), nullable=False)
    content = Column(Text, nullable=False)
    confidence = Column(Float, nullable=False)
    dismissed = Column(Boolean, default=False, nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow, nullable=False)
    
    __table_args__ = (
        Index("idx_insights_user_dismissed", "user_id", "dismissed"),
        CheckConstraint("confidence >= 0 AND confidence <= 1", name="check_insight_confidence"),
    )
    
    def __repr__(self):
        return f"<Insight(id={self.id}, type={self.type})>"
