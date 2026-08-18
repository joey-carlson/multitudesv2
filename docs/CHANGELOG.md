# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- **Flutter app scaffold (`app/`)** — local-first client (Phase 2). Dart port of
  the persona domain (archetypes, templates, generator), on-device SQLite via
  Drift, an onboarding survey screen and a home screen. Runs on macOS.
- **Persona detail + "who's active now"** — home cards show a live energy-state
  badge (peak/recovery/trough/steady) from the ported energy model; tapping a
  persona opens a detail view (energy rhythm, strengths, growth areas, triggers,
  ideal tasks).
- **Energy check-ins** — `energy_readings` table (Drift schema v2 + migration);
  log a persona's current energy (1–10) and view recent check-ins, stored
  locally.
- **Task management** — `tasks` table (Drift schema v3 + migration); add tasks
  to a persona (energy required, estimated effort) and complete them, on the
  persona detail screen.
- **Balance dashboard** — ideal vs. actual weekly hours per persona; actual
  hours are derived from tasks completed in the last 7 days
  (`Persona.balanceScore` ported from Python).
- **Fed/over-fed/starving dashboard (roadmap F3)** — reframes balance as persona
  "feeding": `Persona.fedState` classifier (heuristics-first), a summary header
  with counts, attention-first ordering, and a home-screen banner surfacing
  starving personas. Verified: `flutter analyze` clean, 32 Flutter tests passing.
- **Calendar integration (roadmap F1)** — reads the device calendar and matches
  events to personas. Heuristic event→persona matching (keyword overlap) plus a
  peak-window timing flag (`rankPersonasForEvent`); a Calendar screen listing
  upcoming events with their best-fit persona and good/poor-timing notes. Native
  macOS EventKit source behind a `CalendarSource` abstraction (calendar
  entitlement + usage description), with a sample source fallback on other
  platforms. Verified: `flutter analyze` clean, 36 Flutter tests passing.
- **Work/personal calendar classification** — surfaces all calendars (native
  EventKit `listCalendars`), infers Work/Personal from account/type, and lets
  the user tag each Work/Personal/Ignore (persisted, Drift schema v4). The
  calendar view hides ignored calendars, labels events Work/Personal, and
  filters by All/Work/Personal. Outlook is supported by adding the account to
  macOS Calendar (no OAuth). Verified: analyze clean, 43 Flutter tests passing.
- **Hide individual calendar events** — exclude specific events (e.g. a
  coworker's leave on a shared work calendar) from persona/energy consideration
  via a per-event Hide/Unhide menu, with a "show hidden" toggle. Reversible,
  stored locally (Drift schema v5); never modifies the real calendar.
- **Manual persona assignment for events** — assign/change/clear a persona per
  event when auto-matching misses; persists (Drift schema v6) and overrides
  matching. Calendar time now folds into the fed/starving balance (attributed
  via the effective persona over the next 7 days, combined with completed
  tasks), so an assignment visibly feeds its persona. analyze clean, 48 tests.
- **Calendar view QoL** — events grouped under day headers (Today/Tomorrow/
  weekday), a refresh button, a summary line (events · assigned · unmatched ·
  hidden), source calendar name per event, distinct "All day" rendering, and a
  guidance card nudging manual assignment when nothing matched.
- **Manually add personas** — create a new persona from a preset archetype
  (prefilled) or fully custom (name, emoji, energy window, weekly target) via a
  home FAB; persists to the existing store.
- **Edit a persona** — from the detail screen, adjust the peak/recovery/trough
  energy windows, name, emoji, primary energy, and weekly target; persists via
  `updatePersona` and refreshes home/balance.
- **Timing suggestions (roadmap F2)** — events scheduled in a persona's trough
  or off-peak surface a suggestion to move to the persona's peak window: an
  inline hint on the calendar card plus a Suggestions screen (lightbulb, with a
  count badge) aggregating the week. Non-destructive.
- **Persona suggestions (roadmap F5)** — an Insights screen (home ✨) suggests a
  new persona from clusters of unmatched calendar events, and peak-window shifts
  from energy check-ins that fall outside a persona's configured peak; offered
  for approval, never auto-applied. Design grounded in a research pass (IFS
  parts as metaphor, possible-selves, self-complexity coverage, wheel-of-life,
  chronotype; offer-never-assign, no clinical claims). analyze clean, 79 tests.
- **Energy impact (draining/energizing)** — per-event −2..+2 scale (grounded in
  the circumplex arousal axis + SDT vitality): a heuristic seed from the
  matched persona's energy state at the event time, user-overridable via a
  picker, shown as a tappable chip and summed into a "net energy" readout
  (Drift schema v7).
- **Improved persona↔event matching** — added per-archetype keyword lexicons
  and a composite score (keyword overlap + time-of-day prior + work/personal
  domain prior) so auto-match fires on real calendar titles, not just events
  containing a persona's own words.
- **Learn from corrections** — manual persona assignments now teach the matcher
  (event title/notes tokens → persona, weighted; Drift schema v8), so similar
  future events auto-match. Learned tokens create matches on their own and
  outweigh weak lexicon hits. Groundwork for F5. analyze clean, 67 tests.
- **Design note** (`PARKING_LOT.md`): energizing-vs-draining activities grounded
  in existing research (Russell's circumplex valence/arousal, SDT subjective
  vitality, Mood Meter) with a heuristics-first design — rather than inventing.
- **Persona Intelligence roadmap** (`PARKING_LOT.md`) — calendar-aware coaching
  direction (F1–F6); F2 and persona-matching improvements deferred with notes.
- **Cross-language contract** — `scripts/export_persona_fixtures.py` generates
  `tests/fixtures/persona_generation_cases.json` from the Python generator (the
  executable spec); both the Python and Dart suites assert against the same
  fixtures, so any Python↔Dart logic drift fails a test. See ARCHITECTURE §0.4.
- Design docs updated to v2.1.0: ARCHITECTURE §0 (smart-device/dumb-server,
  differential LWW sync) and REQUIREMENTS §0 (local-first product direction).

### Changed
- **Local-first architecture**: collapsed the three-service datastore
  (PostgreSQL + InfluxDB + Redis) to a single self-contained **SQLite** file.
  The app now runs on any laptop with zero services and is portable to
  on-device use; PostgreSQL remains an optional backend for a self-hosted sync
  server. Models are dialect-neutral (`JSON` instead of `JSONB`/`ARRAY`), the
  storage layer defaults to `sqlite+aiosqlite` with a portable upsert, and the
  Alembic migrations are squashed into one portable initial migration.
  InfluxDB/Redis/Celery dependencies removed (they were unused in code).

### Fixed
- Onboarding energy-pattern mapping: `PersonaGenerator._extract_energy_config`
  matched stale option strings (e.g. "5am-9am", "6pm-10pm") that no longer
  existed in the survey, so 5 of 10 peak-energy answers silently fell back to
  the archetype default instead of the user's choice. Now matches all 10
  current `overall_energy_pattern` options via a data-driven time-range lookup.

### Added
- First-time onboarding survey (persona discovery wizard):
  - 5-phase survey configuration (`survey_config.py`)
  - Survey-to-persona generator with energy patterns, custom names, and
    weekly-hour allocation (`persona_generator.py`)
  - Onboarding API endpoints: `GET /survey`, `GET /status`, `POST /submit`,
    `GET /personas` (`api/endpoints/onboarding.py`)
  - Streamlit onboarding wizard page with progress and resume
  - Persona/energy-reading schema and Alembic migration
  - Parametrized regression tests guarding survey↔generator option alignment
- Comprehensive user personalization architecture documentation
  - Phase 1: Adaptive Prompt Templates (current focus)
  - Phase 2: RAG + Vector Embeddings (future)
  - Phase 3: Local/Edge Learning for mobile (future)
- Mobile-first architecture design
  - Storage abstraction layer (PostgreSQL/SQLite compatible)
  - Offline-first capabilities
  - Differential sync protocol
  - Privacy-preserving aggregation
- Context persistence strategy with time-based decay weighting
- Docker setup with PostgreSQL, InfluxDB, and Redis
- Development environment automation scripts
- Docker guide for beginners

### Planned
- Apple Mail integration
- Apple Calendar integration
- Basic task management
- Energy tracking system
- AI insights engine
- Web dashboard with Streamlit

---

## [2.0.0] - 2025-12-08

### Added
- Initial project structure and documentation
- Comprehensive requirements document (REQUIREMENTS.md)
- Detailed architecture specification (ARCHITECTURE.md)
- Project README with installation and usage instructions
- ClineRules for development standards and best practices
- Directory structure for modular architecture:
  - Core domain logic (personas, learning, scheduler)
  - Data extractors (Apple, Outlook, Google)
  - FastAPI backend
  - Streamlit web dashboard
  - Shared utilities
  - Test suite structure

### Project Initialization
This is the initial release of Multitudes v2.0, a complete rewrite and modernization of the personal AI assistant concept. The project is built from scratch with:
- Clean architecture following SOLID principles
- API-first design for future mobile integration
- Persona-centric approach to productivity
- Multi-database strategy (PostgreSQL + InfluxDB)
- Privacy-first, security-focused implementation
- Comprehensive documentation from day one

### Philosophy
Based on Walt Whitman's "Song of Myself" - recognizing that users are not monolithic but contain multitudes of personas, each deserving attention and balance.

---

## Version History

| Version | Date | Status | Description |
|---------|------|--------|-------------|
| 2.0.0 | 2025-12-08 | Planning | Initial project setup and documentation |

---

## Notes

### Version Number Format
We use semantic versioning (MAJOR.MINOR.PATCH):
- **MAJOR**: Incompatible API changes
- **MINOR**: New functionality in a backwards-compatible manner
- **PATCH**: Backwards-compatible bug fixes

### Changelog Categories
- **Added**: New features
- **Changed**: Changes to existing functionality
- **Deprecated**: Soon-to-be removed features
- **Removed**: Removed features
- **Fixed**: Bug fixes
- **Security**: Security improvements
