"""
Context Manager for User Personalization.

Manages retrieval, aggregation, and storage of user context with time-decay weighting.
This is the core of Phase 1 adaptive personalization.
"""

from typing import Dict, List, Optional, Any
from datetime import datetime, timedelta
from collections import defaultdict

from ..models.user_context import (
    UserContext,
    ContextItem,
    ContextType,
    LearnedFrom,
    calculate_context_relevance
)


class ContextManager:
    """
    Manages user context with intelligent caching and time-decay.
    
    This is a critical component - it determines what the AI knows about
    the user and how relevant that knowledge is.
    """
    
    def __init__(self, storage_backend, cache_ttl_seconds: int = 300):
        """
        Initialize context manager.
        
        Args:
            storage_backend: Database storage (PostgreSQL or SQLite)
            cache_ttl_seconds: How long to cache contexts (default 5 minutes)
        """
        self.storage = storage_backend
        self.cache_ttl = timedelta(seconds=cache_ttl_seconds)
        self._cache: Dict[str, tuple[UserContext, datetime]] = {}
    
    async def get_context(
        self,
        user_id: str,
        include_types: Optional[List[ContextType]] = None,
        current_context: Optional[Dict[str, Any]] = None
    ) -> UserContext:
        """
        Get user context with time-decay weighting applied.
        
        This is the main entry point for retrieving personalized context.
        
        Args:
            user_id: User identifier
            include_types: Filter by context types (None = all types)
            current_context: Current situational context for relevance boost
            
        Returns:
            Aggregated user context with weighted patterns
        """
        # Check cache first
        cached = self._get_from_cache(user_id)
        if cached:
            return cached
        
        # Fetch from database
        context_items = await self.storage.fetch_user_contexts(
            user_id=user_id,
            context_types=include_types
        )
        
        # Apply time decay and relevance weighting
        weighted_items = self._apply_weights(
            context_items,
            current_context
        )
        
        # Aggregate into UserContext
        aggregated = self._aggregate_contexts(user_id, weighted_items)
        
        # Cache for future use
        self._add_to_cache(user_id, aggregated)
        
        return aggregated
    
    def _apply_weights(
        self,
        items: List[ContextItem],
        current_context: Optional[Dict[str, Any]]
    ) -> List[ContextItem]:
        """Apply time-decay and contextual relevance weighting"""
        current_time = datetime.utcnow()
        
        for item in items:
            # Apply time decay
            item.apply_time_decay()
            
            # Calculate overall relevance
            relevance = calculate_context_relevance(
                item,
                current_time,
                current_context
            )
            
            # Store as final weight
            item.weight = relevance
        
        # Sort by relevance (highest first)
        return sorted(items, key=lambda x: x.weight, reverse=True)
    
    def _aggregate_contexts(
        self,
        user_id: str,
        items: List[ContextItem]
    ) -> UserContext:
        """
        Aggregate context items into structured UserContext.
        
        Groups items by type and applies weighting to create
        a coherent picture of the user.
        """
        preferences = {}
        patterns = []
        stats = {}
        persona_affinities = {}
        
        for item in items:
            if item.context_type == ContextType.PREFERENCE:
                preferences[item.key] = item.value
            
            elif item.context_type == ContextType.PATTERN:
                # Only include high-confidence patterns
                if item.confidence > 0.6:
                    patterns.append(item.value)
            
            elif item.context_type == ContextType.STAT:
                stats[item.key] = item.value
            
            elif item.context_type == ContextType.PERSONA_AFFINITY:
                persona_affinities[item.key] = item.value
        
        # Limit patterns to top 10 most relevant
        patterns = patterns[:10]
        
        return UserContext(
            user_id=user_id,
            preferences=preferences,
            patterns=patterns,
            stats=stats,
            persona_affinities=persona_affinities
        )
    
    async def update_context(
        self,
        user_id: str,
        context_type: ContextType,
        key: str,
        value: Any,
        confidence: float = 1.0,
        learned_from: LearnedFrom = LearnedFrom.PATTERN
    ) -> None:
        """
        Update or create a context item.
        
        Args:
            user_id: User identifier
            context_type: Type of context being updated
            key: Context key/identifier
            value: Context value
            confidence: How confident we are (0.0 to 1.0)
            learned_from: Source of this learning
        """
        context_item = ContextItem(
            id=None,  # Will be assigned by database
            user_id=user_id,
            context_type=context_type,
            key=key,
            value=value,
            confidence=confidence,
            learned_from=learned_from
        )
        
        await self.storage.save_context(context_item)
        
        # Invalidate cache
        self._invalidate_cache(user_id)
    
    async def learn_from_feedback(
        self,
        user_id: str,
        interaction_type: str,
        feedback_type: str,
        feedback_data: Dict[str, Any]
    ) -> None:
        """
        Learn from user feedback to improve context.
        
        This is how the system gets smarter over time.
        
        Args:
            user_id: User identifier
            interaction_type: What was the AI doing
            feedback_type: 'accepted', 'rejected', or 'modified'
            feedback_data: Details about the feedback
        """
        # Extract patterns from feedback
        patterns = self._extract_patterns_from_feedback(
            interaction_type,
            feedback_type,
            feedback_data
        )
        
        # Update context based on patterns
        for pattern_type, pattern_data in patterns.items():
            if feedback_type == "accepted":
                # Strengthen this pattern
                await self._strengthen_pattern(
                    user_id,
                    pattern_type,
                    pattern_data
                )
            elif feedback_type == "rejected":
                # Weaken or remove this pattern
                await self._weaken_pattern(
                    user_id,
                    pattern_type,
                    pattern_data
                )
            elif feedback_type == "modified":
                # Learn the modification
                await self._learn_modification(
                    user_id,
                    pattern_type,
                    pattern_data,
                    feedback_data.get("modification")
                )
    
    def _extract_patterns_from_feedback(
        self,
        interaction_type: str,
        feedback_type: str,
        feedback_data: Dict[str, Any]
    ) -> Dict[str, Any]:
        """Extract learnable patterns from user feedback"""
        patterns = {}
        
        if interaction_type == "task_suggestion":
            # Learn task preferences
            if "task_type" in feedback_data:
                patterns["task_preference"] = feedback_data["task_type"]
            if "time_of_day" in feedback_data:
                patterns["time_preference"] = feedback_data["time_of_day"]
        
        elif interaction_type == "persona_detection":
            # Learn persona patterns
            if "detected_persona" in feedback_data:
                patterns["persona_accuracy"] = feedback_data["detected_persona"]
        
        elif interaction_type == "energy_forecast":
            # Learn energy patterns
            if "energy_level" in feedback_data:
                patterns["energy_accuracy"] = feedback_data["energy_level"]
        
        return patterns
    
    async def _strengthen_pattern(
        self,
        user_id: str,
        pattern_type: str,
        pattern_data: Any
    ) -> None:
        """Increase confidence in a pattern"""
        # Fetch existing pattern
        existing = await self.storage.fetch_context_item(
            user_id,
            ContextType.PATTERN,
            pattern_type
        )
        
        if existing:
            # Increase confidence (max 1.0)
            new_confidence = min(1.0, existing.confidence + 0.1)
            await self.storage.update_confidence(
                existing.id,
                new_confidence
            )
        else:
            # Create new pattern
            await self.update_context(
                user_id=user_id,
                context_type=ContextType.PATTERN,
                key=pattern_type,
                value=pattern_data,
                confidence=0.7,
                learned_from=LearnedFrom.FEEDBACK
            )
    
    async def _weaken_pattern(
        self,
        user_id: str,
        pattern_type: str,
        pattern_data: Any
    ) -> None:
        """Decrease confidence in a pattern"""
        existing = await self.storage.fetch_context_item(
            user_id,
            ContextType.PATTERN,
            pattern_type
        )
        
        if existing:
            # Decrease confidence (min 0.0)
            new_confidence = max(0.0, existing.confidence - 0.2)
            
            if new_confidence < 0.3:
                # Remove if too low
                await self.storage.delete_context_item(existing.id)
            else:
                await self.storage.update_confidence(
                    existing.id,
                    new_confidence
                )
    
    async def _learn_modification(
        self,
        user_id: str,
        pattern_type: str,
        original_data: Any,
        modification: Any
    ) -> None:
        """Learn from user's modification of AI suggestion"""
        # Create new pattern based on modification
        await self.update_context(
            user_id=user_id,
            context_type=ContextType.PATTERN,
            key=f"{pattern_type}_modified",
            value=modification,
            confidence=0.8,
            learned_from=LearnedFrom.FEEDBACK
        )
    
    def _get_from_cache(self, user_id: str) -> Optional[UserContext]:
        """Get from memory cache if not expired"""
        if user_id in self._cache:
            context, cached_at = self._cache[user_id]
            if datetime.utcnow() - cached_at < self.cache_ttl:
                return context
        return None
    
    def _add_to_cache(self, user_id: str, context: UserContext) -> None:
        """Add to memory cache"""
        self._cache[user_id] = (context, datetime.utcnow())
    
    def _invalidate_cache(self, user_id: str) -> None:
        """Remove from cache after update"""
        if user_id in self._cache:
            del self._cache[user_id]
    
    async def get_context_statistics(self, user_id: str) -> Dict[str, Any]:
        """
        Get statistics about user's context.
        
        Useful for debugging and showing users what the system knows.
        """
        all_items = await self.storage.fetch_user_contexts(user_id)
        
        return {
            "total_contexts": len(all_items),
            "by_type": {
                ct.value: len([i for i in all_items if i.context_type == ct])
                for ct in ContextType
            },
            "by_source": {
                lf.value: len([i for i in all_items if i.learned_from == lf])
                for lf in LearnedFrom
            },
            "average_confidence": sum(i.confidence for i in all_items) / len(all_items) if all_items else 0,
            "oldest_context": min((i.created_at for i in all_items), default=None),
            "newest_context": max((i.created_at for i in all_items), default=None),
        }
