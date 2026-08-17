"""
SQL Storage Backend for User Context.

Implements the storage interface for Context Manager over any SQLAlchemy
dialect. Defaults to a local SQLite file (local-first, self-contained) and
also supports PostgreSQL for an optional self-hosted sync server.
"""

import os
from typing import List, Optional, Dict, Any
from datetime import datetime
from contextlib import asynccontextmanager

from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession, async_sessionmaker
from sqlalchemy import select, update, delete, and_, or_

from .models import Base, User, UserContextDB, UserFeedbackDB, Persona, Task
from ...core.models.user_context import (
    ContextItem,
    ContextType,
    LearnedFrom,
    UserFeedback,
)


class SqlContextStorage:
    """
    SQL storage backend for user context persistence.

    Defaults to a local SQLite file (self-contained, no services). Also works
    against PostgreSQL for an optional sync server. Handles all database
    operations for user contexts, feedback, and related data.
    """

    def __init__(self, database_url: Optional[str] = None):
        """
        Initialize SQL storage.

        Args:
            database_url: SQLAlchemy connection URL. If None, reads from the
                DATABASE_URL env var, falling back to a local SQLite file.
        """
        if database_url is None:
            database_url = os.getenv(
                "DATABASE_URL",
                "sqlite+aiosqlite:///./multitudes.db"
            )

        # Normalize sync driver URLs to their async equivalents
        if database_url.startswith("postgresql://"):
            database_url = database_url.replace("postgresql://", "postgresql+asyncpg://", 1)
        elif database_url.startswith("sqlite://") and "+aiosqlite" not in database_url:
            database_url = database_url.replace("sqlite://", "sqlite+aiosqlite://", 1)

        # SQLite doesn't use a server-style connection pool; QueuePool sizing
        # args are invalid there, so only pass them for networked databases.
        engine_kwargs: Dict[str, Any] = {"echo": False}
        if database_url.startswith("sqlite"):
            engine_kwargs["connect_args"] = {"check_same_thread": False}
        else:
            engine_kwargs["pool_size"] = 10
            engine_kwargs["max_overflow"] = 20

        self.engine = create_async_engine(database_url, **engine_kwargs)

        self.async_session_maker = async_sessionmaker(
            self.engine,
            class_=AsyncSession,
            expire_on_commit=False,
        )
    
    @asynccontextmanager
    async def get_session(self):
        """Get async database session"""
        async with self.async_session_maker() as session:
            try:
                yield session
                await session.commit()
            except Exception:
                await session.rollback()
                raise
    
    async def fetch_user_contexts(
        self,
        user_id: str,
        context_types: Optional[List[ContextType]] = None
    ) -> List[ContextItem]:
        """
        Fetch all contexts for a user.
        
        Args:
            user_id: User identifier
            context_types: Optional filter by context types
            
        Returns:
            List of ContextItem objects
        """
        async with self.get_session() as session:
            query = select(UserContextDB).where(UserContextDB.user_id == user_id)
            
            if context_types:
                type_values = [ct.value for ct in context_types]
                query = query.where(UserContextDB.context_type.in_(type_values))
            
            result = await session.execute(query)
            db_contexts = result.scalars().all()
            
            # Convert to ContextItem objects
            return [self._db_to_context_item(db_ctx) for db_ctx in db_contexts]
    
    async def fetch_context_item(
        self,
        user_id: str,
        context_type: ContextType,
        key: str
    ) -> Optional[ContextItem]:
        """
        Fetch a specific context item.
        
        Args:
            user_id: User identifier
            context_type: Type of context
            key: Context key
            
        Returns:
            ContextItem or None if not found
        """
        async with self.get_session() as session:
            query = select(UserContextDB).where(
                and_(
                    UserContextDB.user_id == user_id,
                    UserContextDB.context_type == context_type.value,
                    UserContextDB.key == key
                )
            )
            
            result = await session.execute(query)
            db_context = result.scalar_one_or_none()
            
            if db_context:
                return self._db_to_context_item(db_context)
            return None
    
    async def save_context(self, context_item: ContextItem) -> None:
        """
        Save or update a context item.
        
        Uses upsert to handle both insert and update cases.
        
        Args:
            context_item: Context item to save
        """
        now = datetime.utcnow()
        async with self.get_session() as session:
            # Dialect-neutral upsert: update the existing row for this
            # (user_id, context_type, key) if present, otherwise insert.
            existing = await session.execute(
                select(UserContextDB).where(
                    and_(
                        UserContextDB.user_id == context_item.user_id,
                        UserContextDB.context_type == context_item.context_type.value,
                        UserContextDB.key == context_item.key,
                    )
                )
            )
            row = existing.scalar_one_or_none()

            if row is not None:
                row.value = context_item.value
                row.confidence = context_item.confidence
                row.weight = context_item.weight
                row.updated_at = now
                row.last_accessed = now
            else:
                session.add(UserContextDB(
                    user_id=context_item.user_id,
                    context_type=context_item.context_type.value,
                    key=context_item.key,
                    value=context_item.value,
                    confidence=context_item.confidence,
                    weight=context_item.weight,
                    learned_from=context_item.learned_from.value,
                    created_at=context_item.created_at,
                    updated_at=now,
                    last_accessed=now,
                ))
    
    async def update_confidence(self, context_id: str, new_confidence: float) -> None:
        """
        Update confidence score for a context item.
        
        Args:
            context_id: Context item ID
            new_confidence: New confidence value (0.0 to 1.0)
        """
        async with self.get_session() as session:
            stmt = (
                update(UserContextDB)
                .where(UserContextDB.id == context_id)
                .values(
                    confidence=new_confidence,
                    updated_at=datetime.utcnow()
                )
            )
            await session.execute(stmt)
    
    async def delete_context_item(self, context_id: str) -> None:
        """
        Delete a context item.
        
        Args:
            context_id: Context item ID
        """
        async with self.get_session() as session:
            stmt = delete(UserContextDB).where(UserContextDB.id == context_id)
            await session.execute(stmt)
    
    async def save_feedback(self, feedback: UserFeedback) -> None:
        """
        Save user feedback.
        
        Args:
            feedback: UserFeedback object
        """
        async with self.get_session() as session:
            db_feedback = UserFeedbackDB(
                user_id=feedback.user_id,
                interaction_type=feedback.interaction_type,
                interaction_data=feedback.interaction_data,
                feedback_type=feedback.feedback_type,
                feedback_data=feedback.feedback_data,
                created_at=feedback.created_at,
            )
            session.add(db_feedback)
    
    async def fetch_recent_feedback(
        self,
        user_id: str,
        limit: int = 10
    ) -> List[UserFeedback]:
        """
        Fetch recent feedback for a user.
        
        Args:
            user_id: User identifier
            limit: Maximum number of items to return
            
        Returns:
            List of UserFeedback objects
        """
        async with self.get_session() as session:
            query = (
                select(UserFeedbackDB)
                .where(UserFeedbackDB.user_id == user_id)
                .order_by(UserFeedbackDB.created_at.desc())
                .limit(limit)
            )
            
            result = await session.execute(query)
            db_feedbacks = result.scalars().all()
            
            return [self._db_to_feedback(fb) for fb in db_feedbacks]
    
    async def create_user(
        self,
        user_id: str,
        email: Optional[str] = None,
        display_name: Optional[str] = None,
        passphrase_hash: Optional[str] = None
    ) -> User:
        """
        Create a new user.
        
        Args:
            user_id: Unique user identifier
            email: User email (optional)
            display_name: Display name (optional)
            passphrase_hash: Hashed passphrase for auth (optional)
            
        Returns:
            Created User object
        """
        async with self.get_session() as session:
            user = User(
                id=user_id,
                email=email,
                display_name=display_name,
                passphrase_hash=passphrase_hash,
                created_at=datetime.utcnow(),
            )
            session.add(user)
            await session.flush()
            return user
    
    async def get_user_by_id(self, user_id: str) -> Optional[User]:
        """Get user by ID"""
        async with self.get_session() as session:
            result = await session.execute(
                select(User).where(User.id == user_id)
            )
            return result.scalar_one_or_none()
    
    async def get_user_by_email(self, email: str) -> Optional[User]:
        """Get user by email"""
        async with self.get_session() as session:
            result = await session.execute(
                select(User).where(User.email == email)
            )
            return result.scalar_one_or_none()
    
    async def update_last_login(self, user_id: str) -> None:
        """Update user's last login timestamp"""
        async with self.get_session() as session:
            stmt = (
                update(User)
                .where(User.id == user_id)
                .values(last_login=datetime.utcnow())
            )
            await session.execute(stmt)
    
    def _db_to_context_item(self, db_context: UserContextDB) -> ContextItem:
        """Convert database model to ContextItem"""
        return ContextItem(
            id=db_context.id,
            user_id=db_context.user_id,
            context_type=ContextType(db_context.context_type),
            key=db_context.key,
            value=db_context.value,
            confidence=db_context.confidence,
            weight=db_context.weight,
            learned_from=LearnedFrom(db_context.learned_from),
            created_at=db_context.created_at,
            updated_at=db_context.updated_at,
            last_accessed=db_context.last_accessed,
        )
    
    def _db_to_feedback(self, db_feedback: UserFeedbackDB) -> UserFeedback:
        """Convert database model to UserFeedback"""
        return UserFeedback(
            id=db_feedback.id,
            user_id=db_feedback.user_id,
            interaction_type=db_feedback.interaction_type,
            interaction_data=db_feedback.interaction_data,
            feedback_type=db_feedback.feedback_type,
            feedback_data=db_feedback.feedback_data,
            created_at=db_feedback.created_at,
        )
    
    async def close(self):
        """Close database connections"""
        await self.engine.dispose()


# Backwards-compatible alias: the class was PostgreSQL-only before the move to
# a dialect-neutral, SQLite-first backend. Existing imports keep working.
PostgresContextStorage = SqlContextStorage


# Global storage instance for FastAPI dependency injection
_storage_instance: Optional[SqlContextStorage] = None


def get_storage() -> SqlContextStorage:
    """Get global storage instance"""
    global _storage_instance
    if _storage_instance is None:
        _storage_instance = SqlContextStorage()
    return _storage_instance


async def get_db():
    """
    FastAPI dependency for database sessions.
    
    Usage:
        @router.get("/example")
        async def example(db: AsyncSession = Depends(get_db)):
            # Use db session here
            pass
    """
    storage = get_storage()
    async with storage.get_session() as session:
        yield session
