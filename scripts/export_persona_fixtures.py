"""
Export canonical persona-generation fixtures.

The Python persona generator is the executable specification for persona
creation (see docs/ARCHITECTURE.md §0.4). This script runs the generator over a
curated set of survey inputs and writes the results to a language-neutral JSON
file. Both the Python test suite and the future Dart (Flutter) test suite assert
against this same file, so any behavioral drift between the two implementations
becomes a failing test rather than a silent bug.

Regenerate whenever persona-generation logic changes intentionally:

    python scripts/export_persona_fixtures.py

Then run the test suites; both must pass against the regenerated fixtures.
"""

import json
import os
import sys
from datetime import time
from typing import Any, Dict, List

# Allow running as a plain script from the repo root
sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

from src.core.personas import generate_personas_from_survey  # noqa: E402
from src.core.personas.survey_config import get_question_by_id  # noqa: E402

FIXTURE_PATH = os.path.join(
    os.path.dirname(__file__), "..", "tests", "fixtures", "persona_generation_cases.json"
)


def _fmt_time(t: Any) -> Any:
    """Serialize a datetime.time as 'HH:MM', passing through None."""
    return t.strftime("%H:%M") if isinstance(t, time) else None


def _persona_to_dict(p: Any) -> Dict[str, Any]:
    """Language-neutral view of a Persona (id/timestamps excluded — not stable)."""
    return {
        "name": p.name,
        "emoji": p.emoji,
        "archetype": p.archetype.value,
        "primary_energy": p.primary_energy,
        "strengths": p.strengths,
        "weaknesses": p.weaknesses,
        "trigger_conditions": p.trigger_conditions,
        "ideal_tasks": p.ideal_tasks,
        "peak_start_time": _fmt_time(p.peak_start_time),
        "peak_end_time": _fmt_time(p.peak_end_time),
        "trough_start_time": _fmt_time(p.trough_start_time),
        "trough_end_time": _fmt_time(p.trough_end_time),
        "recovery_start_time": _fmt_time(p.recovery_start_time),
        "recovery_end_time": _fmt_time(p.recovery_end_time),
        "ideal_weekly_hours": p.ideal_weekly_hours,
    }


def _build_cases() -> List[Dict[str, Any]]:
    """Curated survey inputs covering the mapping surface."""
    cases: List[Dict[str, Any]] = []

    # One case per peak-energy option, using a single Professional persona, to
    # lock every survey option to its expected peak window.
    for option in get_question_by_id("overall_energy_pattern").options:
        cases.append({
            "name": f"peak_option::{option}",
            "input": {
                "archetypes_selection": [
                    "🧠 The Professional - Responsible, structured, goal-focused"
                ],
                "overall_energy_pattern": option,
            },
        })

    # Multi-persona case with custom names, an energy dip, and time allocation.
    cases.append({
        "name": "two_personas_custom_names_with_dip_and_allocation",
        "input": {
            "archetypes_selection": [
                "🧠 The Professional - Responsible, structured, goal-focused",
                "🎨 The Artist - Expressive, introspective, imaginative",
            ],
            "custom_persona_names": "Executive Emma, Creative Chris",
            "overall_energy_pattern": "Early morning (7am-9am) - Pre-business hours",
            "energy_dip": "Yes, I notice a definite slump",
            "energy_dip_time": "Early afternoon (12pm-2pm)",
            "weekly_time_allocation": "Work: 40hrs, Creative: 10hrs",
        },
    })

    # "Create my own" only → CUSTOM has no template, so no personas are produced.
    cases.append({
        "name": "create_my_own_only_yields_no_personas",
        "input": {"archetypes_selection": ["✨ I'll create my own"]},
    })

    return cases


def main() -> None:
    cases = _build_cases()
    for case in cases:
        personas = generate_personas_from_survey("fixture-user", case["input"])
        case["expected"] = [_persona_to_dict(p) for p in personas]

    os.makedirs(os.path.dirname(FIXTURE_PATH), exist_ok=True)
    with open(FIXTURE_PATH, "w", encoding="utf-8") as f:
        json.dump({"cases": cases}, f, indent=2, ensure_ascii=False)
        f.write("\n")

    print(f"Wrote {len(cases)} cases to {os.path.relpath(FIXTURE_PATH)}")


if __name__ == "__main__":
    main()
