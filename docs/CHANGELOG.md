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
- **Persona Intelligence roadmap** (`PARKING_LOT.md`) — calendar-aware coaching
  direction (F1–F6) with cross-cutting decisions and a build sequence.
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
