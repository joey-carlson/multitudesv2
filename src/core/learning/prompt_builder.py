"""
Personalized Prompt Builder.

Constructs AI prompts with user-specific context to achieve personalization
without requiring model fine-tuning (Phase 1 approach).
"""

from typing import List, Dict, Any, Optional
from datetime import datetime

from ..models.user_context import UserContext
from .context_manager import ContextManager


class PersonalizedPromptBuilder:
    """
    Builds context-aware prompts for AI interactions.
    
    This is how we achieve personalization in Phase 1 - by dynamically
    constructing prompts that include the user's patterns, preferences,
    and historical context.
    """
    
    def __init__(self, context_manager: ContextManager):
        """
        Initialize prompt builder.
        
        Args:
            context_manager: Context manager for retrieving user context
        """
        self.context_manager = context_manager
    
    async def build_task_suggestion_prompt(
        self,
        user_id: str,
        current_tasks: List[Dict[str, Any]],
        current_time: Optional[datetime] = None,
        active_persona: Optional[Dict[str, Any]] = None
    ) -> str:
        """
        Build prompt for task suggestions.
        
        Args:
            user_id: User identifier
            current_tasks: List of current tasks
            current_time: Current datetime (defaults to now)
            active_persona: Currently active persona
            
        Returns:
            Personalized prompt for task suggestions
        """
        if current_time is None:
            current_time = datetime.utcnow()
        
        # Get user context
        user_context = await self.context_manager.get_context(
            user_id=user_id,
            current_context={
                "time_of_day": current_time.hour,
                "day_of_week": current_time.weekday()
            }
        )
        
        # Build persona context if available
        persona_context = ""
        if active_persona:
            persona_context = f"""
Active Persona: {active_persona.get('name', 'Unknown')}
Persona Energy Level: {active_persona.get('energy_level', 'Unknown')}
Persona Preferences: {', '.join(active_persona.get('preferred_task_types', []))}
"""
        
        # Format current tasks
        tasks_text = self._format_tasks(current_tasks[:10])  # Limit to 10 for prompt size
        
        # Build complete prompt
        prompt = f"""
{user_context.to_prompt_context()}
{persona_context}

Current Context:
- Time: {current_time.strftime('%A, %B %d, %Y at %I:%M %p')}
- Day of Week: {current_time.strftime('%A')}
- Number of Tasks: {len(current_tasks)}

Current Tasks (Top 10):
{tasks_text}

Based on this user's patterns, preferences, and current state, suggest:
1. Which task to work on next (with reasoning)
2. Optimal duration for this work session
3. Any schedule adjustments needed
4. Energy management recommendations

Format your response as JSON:
{{
    "recommended_task_id": "task_id",
    "reasoning": "why this task now",
    "duration_minutes": 45,
    "schedule_adjustments": ["suggestion 1", "suggestion 2"],
    "energy_tips": ["tip 1", "tip 2"]
}}
"""
        return prompt
    
    async def build_persona_detection_prompt(
        self,
        user_id: str,
        current_activity: str,
        recent_tasks: List[Dict[str, Any]],
        time_of_day: Optional[datetime] = None
    ) -> str:
        """
        Build prompt for detecting which persona is currently active.
        
        Args:
            user_id: User identifier
            current_activity: What the user is currently doing
            recent_tasks: Recently completed tasks
            time_of_day: Current time
            
        Returns:
            Personalized prompt for persona detection
        """
        if time_of_day is None:
            time_of_day = datetime.utcnow()
        
        user_context = await self.context_manager.get_context(user_id)
        
        recent_tasks_text = self._format_tasks(recent_tasks)
        
        prompt = f"""
{user_context.to_prompt_context()}

Current Activity: {current_activity}
Time: {time_of_day.strftime('%A %I:%M %p')}

Recent Tasks (last 5):
{recent_tasks_text}

Persona Affinities:
{self._format_persona_affinities(user_context.persona_affinities)}

Based on the current activity, time of day, recent tasks, and learned patterns,
determine which persona is most likely active right now.

Consider:
- Task types align with persona preferences
- Time of day matches persona's peak hours
- Energy level fits persona's typical patterns
- Recent activity patterns

Respond with JSON:
{{
    "detected_persona_id": "persona_id",
    "confidence": 0.85,
    "reasoning": "why this persona",
    "alternative_personas": [
        {{"id": "persona_id", "confidence": 0.60, "reason": "..."}}
    ]
}}
"""
        return prompt
    
    async def build_energy_forecast_prompt(
        self,
        user_id: str,
        target_date: datetime,
        historical_energy_data: List[Dict[str, Any]]
    ) -> str:
        """
        Build prompt for forecasting energy levels.
        
        Args:
            user_id: User identifier
            target_date: Date to forecast for
            historical_energy_data: Past energy readings
            
        Returns:
            Personalized prompt for energy forecasting
        """
        user_context = await self.context_manager.get_context(user_id)
        
        historical_text = self._format_energy_history(historical_energy_data)
        
        prompt = f"""
{user_context.to_prompt_context()}

Target Date: {target_date.strftime('%A, %B %d, %Y')}

Historical Energy Patterns:
{historical_text}

Based on this user's energy patterns and the target date, forecast:
1. Hourly energy levels for the day
2. Peak energy periods
3. Low energy periods
4. Recommended task distribution

Consider:
- Day of week patterns
- Typical peak/low times
- Recent trends
- User's stated preferences

Respond with JSON:
{{
    "hourly_forecast": [
        {{"hour": 9, "energy_level": 4, "confidence": 0.8}},
        ...
    ],
    "peak_periods": [{{"start": "09:00", "end": "11:00", "energy": 4}}],
    "low_periods": [{{"start": "14:00", "end": "15:00", "energy": 2}}],
    "recommendations": [
        "Schedule deep work during 9-11am",
        "Keep meetings light in early afternoon"
    ]
}}
"""
        return prompt
    
    async def build_schedule_optimization_prompt(
        self,
        user_id: str,
        tasks_to_schedule: List[Dict[str, Any]],
        available_time_blocks: List[Dict[str, Any]],
        constraints: Dict[str, Any]
    ) -> str:
        """
        Build prompt for optimizing task schedule.
        
        Args:
            user_id: User identifier
            tasks_to_schedule: Tasks needing scheduling
            available_time_blocks: Available time slots
            constraints: Scheduling constraints
            
        Returns:
            Personalized prompt for schedule optimization
        """
        user_context = await self.context_manager.get_context(user_id)
        
        tasks_text = self._format_tasks(tasks_to_schedule)
        blocks_text = self._format_time_blocks(available_time_blocks)
        
        prompt = f"""
{user_context.to_prompt_context()}

Tasks to Schedule:
{tasks_text}

Available Time Blocks:
{blocks_text}

Constraints:
{self._format_constraints(constraints)}

Based on this user's preferences, energy patterns, and persona affinities,
create an optimal schedule that:
1. Matches high-energy work to peak energy times
2. Groups similar tasks for flow
3. Respects persona preferences
4. Balances all personas over time
5. Includes appropriate breaks

Respond with JSON:
{{
    "schedule": [
        {{
            "task_id": "task_id",
            "start_time": "09:00",
            "end_time": "10:00",
            "reasoning": "why this slot"
        }},
        ...
    ],
    "persona_balance": {{
        "persona_id": {{"hours": 3, "tasks": 2}},
        ...
    }},
    "recommendations": ["recommendation 1", "recommendation 2"]
}}
"""
        return prompt
    
    async def build_feedback_analysis_prompt(
        self,
        user_id: str,
        feedback_history: List[Dict[str, Any]]
    ) -> str:
        """
        Build prompt for analyzing feedback to extract patterns.
        
        Args:
            user_id: User identifier
            feedback_history: Recent feedback from user
            
        Returns:
            Prompt for pattern extraction
        """
        user_context = await self.context_manager.get_context(user_id)
        
        feedback_text = self._format_feedback_history(feedback_history)
        
        prompt = f"""
{user_context.to_prompt_context()}

Recent User Feedback:
{feedback_text}

Analyze this feedback to identify:
1. Patterns in user preferences
2. What the AI got right/wrong
3. Emerging trends in user behavior
4. Recommendations for improving suggestions

Respond with JSON:
{{
    "identified_patterns": [
        {{"pattern": "prefers morning coding", "confidence": 0.9, "evidence": "..."}}
    ],
    "successes": ["what worked well"],
    "failures": ["what needs improvement"],
    "recommendations": ["how to improve"]
}}
"""
        return prompt
    
    def _format_tasks(self, tasks: List[Dict[str, Any]]) -> str:
        """Format tasks for prompt"""
        if not tasks:
            return "No tasks"
        
        formatted = []
        for i, task in enumerate(tasks[:10], 1):
            formatted.append(
                f"{i}. {task.get('title', 'Untitled')} "
                f"[Priority: {task.get('priority', 'N/A')}, "
                f"Energy: {task.get('energy_required', 'N/A')}, "
                f"Duration: {task.get('estimated_duration', 'N/A')} min]"
            )
        return "\n".join(formatted)
    
    def _format_persona_affinities(self, affinities: Dict[str, float]) -> str:
        """Format persona affinities for prompt"""
        if not affinities:
            return "No persona affinities learned yet"
        
        return "\n".join([
            f"- {persona}: {affinity:.2f}"
            for persona, affinity in sorted(
                affinities.items(),
                key=lambda x: x[1],
                reverse=True
            )
        ])
    
    def _format_energy_history(self, history: List[Dict[str, Any]]) -> str:
        """Format energy history for prompt"""
        if not history:
            return "No historical data available"
        
        formatted = []
        for entry in history[-20:]:  # Last 20 entries
            formatted.append(
                f"- {entry.get('timestamp', 'Unknown')}: "
                f"Energy {entry.get('energy_level', 'N/A')}/5 "
                f"({entry.get('activity_type', 'Unknown')})"
            )
        return "\n".join(formatted)
    
    def _format_time_blocks(self, blocks: List[Dict[str, Any]]) -> str:
        """Format time blocks for prompt"""
        if not blocks:
            return "No available time blocks"
        
        return "\n".join([
            f"- {block.get('start', 'N/A')} to {block.get('end', 'N/A')} "
            f"({block.get('duration_minutes', 'N/A')} minutes)"
            for block in blocks
        ])
    
    def _format_constraints(self, constraints: Dict[str, Any]) -> str:
        """Format constraints for prompt"""
        if not constraints:
            return "No constraints"
        
        return "\n".join([
            f"- {key}: {value}"
            for key, value in constraints.items()
        ])
    
    def _format_feedback_history(self, history: List[Dict[str, Any]]) -> str:
        """Format feedback history for prompt"""
        if not history:
            return "No feedback history"
        
        formatted = []
        for entry in history[-10:]:  # Last 10 entries
            formatted.append(
                f"- {entry.get('interaction_type', 'Unknown')}: "
                f"{entry.get('feedback_type', 'Unknown')} "
                f"({entry.get('timestamp', 'Unknown')})"
            )
        return "\n".join(formatted)


class PromptTemplate:
    """
    Template-based prompt builder for common scenarios.
    
    Simpler alternative when full context isn't needed.
    """
    
    @staticmethod
    def simple_task_suggestion(
        task_list: List[str],
        time_of_day: str
    ) -> str:
        """Simple task suggestion without full context"""
        tasks = "\n".join([f"{i+1}. {task}" for i, task in enumerate(task_list)])
        return f"""
Current time: {time_of_day}

Available tasks:
{tasks}

Which task should I work on next? Consider the time of day and provide reasoning.
"""
    
    @staticmethod
    def quick_energy_check(energy_level: int) -> str:
        """Quick energy level prompt"""
        return f"""
My current energy level is {energy_level}/5.

What type of tasks should I focus on right now? Provide 3 specific recommendations.
"""
