# Multitudes v2.0 - Architecture Document

**Version:** 2.0.0  
**Last Updated:** 2025-12-08  
**Status:** Initial Design

---

## 1. Architectural Overview

Multitudes v2.0 follows a modular, API-first architecture designed for maintainability, scalability, and future mobile integration. The system separates concerns into distinct layers with well-defined interfaces.

### 1.1 High-Level Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    Presentation Layer                    │
│  ┌────────────────┐              ┌──────────────────┐  │
│  │  Streamlit Web │              │  Future: Mobile  │  │
│  │   Dashboard    │              │   App (Flutter)  │  │
│  └────────┬───────┘              └────────┬─────────┘  │
│           │                               │             │
└───────────┼───────────────────────────────┼─────────────┘
            │                               │
            └───────────────┬───────────────┘
                            │
                    ┌───────▼───────┐
                    │   FastAPI     │
                    │  REST API     │
                    └───────┬───────┘
                            │
        ┌───────────────────┼───────────────────┐
        │                   │                   │
┌───────▼────────┐  ┌───────▼────────┐  ┌──────▼──────┐
│  Core Domain   │  │  Data Layer    │  │   External  │
│                │  │                │  │    APIs     │
│ • Personas     │  │ • PostgreSQL   │  │ • Apple     │
│ • Learning     │  │ • InfluxDB     │  │ • Google    │
│ • Scheduler    │  │ • Vector DB    │  │ • Outlook   │
└────────────────┘  └────────────────┘  └─────────────┘
```

## 2. Technology Stack

### 2.1 Backend
- **Language**: Python 3.11+
- **Web Framework**: FastAPI (async, high-performance)
- **Task Queue**: Celery (for background jobs)
- **Message Broker**: Redis (for Celery & caching)

### 2.2 Data Storage
- **Relational DB**: PostgreSQL 15+
  - User profiles, personas, preferences
  - Task definitions, relationships
  - Configuration and metadata
- **Time-Series DB**: InfluxDB 2.x
  - Behavior patterns over time
  - Energy level tracking
  - Task completion metrics
- **Vector DB**: Pinecone or Weaviate
  - Semantic embeddings for tasks
  - Persona pattern matching
  - AI learning features

### 2.3 Frontend
- **Web Dashboard**: Streamlit
  - Rapid development
  - Python-based (consistent with backend)
  - Easy to extend and customize
- **Future Mobile**: Flutter (cross-platform iOS/Android)

### 2.4 AI/ML
- **LLM**: OpenAI API (GPT-4-turbo)
- **Embeddings**: text-embedding-ada-002
- **Local Processing**: spaCy for NLP tasks
- **Pattern Recognition**: scikit-learn for ML models

### 2.5 DevOps & Tooling
- **Containerization**: Docker & Docker Compose
- **Testing**: pytest with fixtures and parameterization
- **Linting**: ruff (fast Python linter)
- **Type Checking**: mypy
- **Database Migrations**: Alembic
- **Version Control**: Git

## 3. Project Structure

```
multitudes_assistant/
├── docs/                      # Documentation
│   ├── REQUIREMENTS.md
│   ├── ARCHITECTURE.md
│   ├── CHANGELOG.md
│   └── README.md
├── src/                       # Source code
│   ├── core/                  # Core domain logic
│   │   ├── personas/          # Persona system
│   │   │   ├── models.py      # Persona dataclasses
│   │   │   ├── detector.py    # Persona detection logic
│   │   │   └── balancer.py    # Balance tracking
│   │   ├── learning/          # AI/ML components
│   │   │   ├── pattern_engine.py
│   │   │   ├── predictor.py
│   │   │   └── feedback_loop.py
│   │   └── scheduler/         # Task scheduling
│   │       ├── energy_aware.py
│   │       └── optimizer.py
│   ├── extractors/            # Data source integrations
│   │   ├── apple/
│   │   │   ├── mail.py
│   │   │   └── calendar.py
│   │   ├── outlook/
│   │   │   ├── mail.py
│   │   │   └── calendar.py
│   │   ├── google/
│   │   │   ├── gmail.py
│   │   │   └── calendar.py
│   │   └── base.py            # Base extractor interface
│   ├── api/                   # FastAPI backend
│   │   ├── endpoints/
│   │   │   ├── auth.py
│   │   │   ├── personas.py
│   │   │   ├── tasks.py
│   │   │   ├── insights.py
│   │   │   └── sync.py
│   │   ├── models/            # Pydantic models
│   │   │   ├── requests.py
│   │   │   └── responses.py
│   │   ├── dependencies.py
│   │   └── main.py            # FastAPI app entry
│   ├── shared/                # Shared utilities
│   │   ├── config/
│   │   │   ├── settings.py    # Configuration management
│   │   │   └── secrets.py     # Credential handling
│   │   ├── database/
│   │   │   ├── postgres.py    # PostgreSQL client
│   │   │   ├── influx.py      # InfluxDB client
│   │   │   └── vector.py      # Vector DB client
│   │   └── logging/
│   │       └── logger.py      # Structured logging
│   └── web/                   # Streamlit dashboard
│       ├── app.py             # Main dashboard
│       └── components/        # Reusable UI components
├── tests/                     # Test suite
│   ├── unit/
│   ├── integration/
│   └── fixtures/
├── alembic/                   # Database migrations
│   ├── versions/
│   └── env.py
├── .env.example               # Environment template
├── .gitignore
├── docker-compose.yml         # Local development setup
├── Dockerfile
├── pyproject.toml             # Python project config
├── requirements.txt           # Dependencies
└── README.md
```

## 4. Data Models

### 4.1 Core Domain Models

```python
from dataclasses import dataclass
from datetime import datetime
from typing import Optional, List
from enum import Enum

@dataclass
class Persona:
    """Represents one aspect of the user's multitudes"""
    id: str
    name: str
    description: str
    energy_patterns: dict  # Time-based energy levels
    preferred_task_types: List[str]
    color_code: str
    icon: str
    created_at: datetime
    updated_at: datetime

@dataclass
class Task:
    """Represents a task/todo item"""
    id: str
    title: str
    description: Optional[str]
    persona_id: str  # Which persona this task belongs to
    priority: int  # 1-5
    energy_required: int  # 1-5
    estimated_duration: int  # minutes
    due_date: Optional[datetime]
    completed: bool
    source: str  # email, calendar, manual
    created_at: datetime
    completed_at: Optional[datetime]

@dataclass
class EnergyReading:
    """Time-series energy level data"""
    timestamp: datetime
    persona_id: str
    energy_level: int  # 1-5
    activity_type: str
    context: dict

@dataclass
class PersonaBalance:
    """Tracks balance across personas"""
    date: datetime
    persona_id: str
    tasks_assigned: int
    tasks_completed: int
    time_spent: int  # minutes
    satisfaction_score: float  # 0-1
```

### 4.2 Database Schema (PostgreSQL)

```sql
-- Users
CREATE TABLE users (
    id UUID PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Personas
CREATE TABLE personas (
    id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    name VARCHAR(100) NOT NULL,
    description TEXT,
    energy_patterns JSONB,
    preferred_task_types TEXT[],
    color_code VARCHAR(7),
    icon VARCHAR(50),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Tasks
CREATE TABLE tasks (
    id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    persona_id UUID REFERENCES personas(id),
    title VARCHAR(500) NOT NULL,
    description TEXT,
    priority INTEGER CHECK (priority BETWEEN 1 AND 5),
    energy_required INTEGER CHECK (energy_required BETWEEN 1 AND 5),
    estimated_duration INTEGER,
    due_date TIMESTAMP,
    completed BOOLEAN DEFAULT FALSE,
    source VARCHAR(50),
    source_metadata JSONB,
    created_at TIMESTAMP DEFAULT NOW(),
    completed_at TIMESTAMP
);

-- Task Dependencies
CREATE TABLE task_dependencies (
    task_id UUID REFERENCES tasks(id),
    depends_on_task_id UUID REFERENCES tasks(id),
    PRIMARY KEY (task_id, depends_on_task_id)
);

-- Insights
CREATE TABLE insights (
    id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    persona_id UUID REFERENCES personas(id),
    type VARCHAR(50),
    content TEXT,
    confidence FLOAT,
    dismissed BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW()
);
```

### 4.3 Time-Series Schema (InfluxDB)

```
Measurement: energy_readings
Tags: user_id, persona_id, context
Fields: energy_level (integer), activity_type (string)
Timestamp: event time

Measurement: task_metrics
Tags: user_id, persona_id, task_id
Fields: duration (integer), completed (boolean)
Timestamp: completion time

Measurement: persona_balance
Tags: user_id, persona_id
Fields: tasks_assigned, tasks_completed, time_spent, satisfaction
Timestamp: aggregation time
```

## 5. API Design

### 5.1 RESTful Endpoints

```
Authentication:
POST   /api/v1/auth/login
POST   /api/v1/auth/refresh
POST   /api/v1/auth/logout

Personas:
GET    /api/v1/personas
POST   /api/v1/personas
GET    /api/v1/personas/{id}
PUT    /api/v1/personas/{id}
DELETE /api/v1/personas/{id}
GET    /api/v1/personas/{id}/balance
GET    /api/v1/personas/{id}/energy-forecast

Tasks:
GET    /api/v1/tasks
POST   /api/v1/tasks
GET    /api/v1/tasks/{id}
PUT    /api/v1/tasks/{id}
DELETE /api/v1/tasks/{id}
POST   /api/v1/tasks/{id}/complete
GET    /api/v1/tasks/recommendations

Insights:
GET    /api/v1/insights
POST   /api/v1/insights/{id}/dismiss
POST   /api/v1/insights/{id}/feedback

Sync:
POST   /api/v1/sync/apple-mail
POST   /api/v1/sync/apple-calendar
POST   /api/v1/sync/outlook
POST   /api/v1/sync/gmail
GET    /api/v1/sync/status

Learning:
POST   /api/v1/learning/feedback
GET    /api/v1/learning/patterns
```

## 6. Key Design Decisions

### 6.1 Why FastAPI?
- **Performance**: Async support for concurrent operations
- **Type Safety**: Built-in Pydantic validation
- **Documentation**: Auto-generated OpenAPI docs
- **Modern**: Python 3.11+ features
- **Mobile Ready**: REST API works with any client

### 6.2 Why Multiple Databases?
- **PostgreSQL**: ACID compliance for critical user data
- **InfluxDB**: Optimized for time-series queries and aggregations
- **Vector DB**: Efficient semantic search for AI features
- **Separation of Concerns**: Each DB serves its purpose optimally

### 6.3 Why Streamlit for Web?
- **Rapid Development**: Quick iteration on UI
- **Python Native**: Same language as backend
- **Good Enough**: Sufficient for MVP and early users
- **Easy Migration**: Can replace with React later if needed

### 6.4 Persona-Centric Architecture
- **Core Abstraction**: Everything revolves around personas
- **Flexibility**: Easy to add new persona types
- **Scalability**: Each persona operates independently
- **User Alignment**: Matches how users think about themselves

## 7. Security Architecture

### 7.1 Authentication & Authorization
- JWT tokens with 1-hour expiration
- Refresh tokens stored securely
- Rate limiting: 100 requests/minute per user
- API key authentication for service-to-service

### 7.2 Data Protection
- Credentials encrypted at rest (Fernet)
- Environment variables for secrets
- No sensitive data in logs
- HTTPS only for production
- Input sanitization on all endpoints

### 7.3 Privacy
- Data stored locally by default
- Optional cloud sync (user controlled)
- No data sharing without consent
- Export and delete capabilities (GDPR compliant)

## 8. Performance Considerations

### 8.1 Optimization Strategies
- Database indexing on frequently queried fields
- Connection pooling for all databases
- Caching with Redis (1-hour TTL)
- Lazy loading of persona data
- Batch operations for bulk inserts
- Async operations for I/O bound tasks

### 8.2 Scalability
- Horizontal scaling via Docker containers
- Database replication for read-heavy workloads
- Background job processing with Celery
- Rate limiting to prevent abuse

## 9. Testing Strategy

### 9.1 Unit Tests (AAA Pattern)
```python
def test_persona_energy_prediction():
    # Arrange
    persona = create_test_persona(energy_patterns={"morning": 5})
    
    # Act
    predicted = persona.predict_energy(time="09:00")
    
    # Assert
    assert predicted == 5
```

### 9.2 Integration Tests
- API endpoint testing with TestClient
- Database integration tests with test fixtures
- External API mocking
- End-to-end workflow tests

### 9.3 Gist Tests
Single test covering primary user journey:
```python
def test_complete_user_journey():
    """Test: Create persona -> Sync data -> Get tasks -> Complete task"""
    # Creates complete flow in one test
```

## 10. Deployment Architecture

### 10.1 Development
- Docker Compose with all services
- Hot reload for code changes
- Local PostgreSQL and InfluxDB
- Mocked external APIs

### 10.2 Production (Future)
- Kubernetes for orchestration
- Managed databases (AWS RDS, InfluxDB Cloud)
- CloudFront for static assets
- Auto-scaling based on load

## 11. Migration Strategy from v1

### 11.1 Data Migration
- Export existing Multitudes v1 data
- Transform to new schema
- Import via API or direct DB insert
- Validation and verification

### 11.2 Feature Parity
- Core features from v2.3 preserved
- Enhanced with new architecture
- Gradual feature rollout

## 12. Future Considerations

### 12.1 Mobile App Integration
- Shared API between web and mobile
- OAuth for mobile authentication
- Offline-first mobile architecture
- Push notifications for insights

### 12.2 Advanced Features
- Voice interface integration
- Machine learning model training
- Real-time collaboration
- Plugin/extension system

---

## Revision History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 2.0.0 | 2025-12-08 | Initial | Created architecture document |
