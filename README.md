# Multitudes v2.0 - Personal AI Assistant

**"I am large, I contain multitudes."** - Walt Whitman

A personal AI assistant that recognizes and nurtures the multiple personas within you, helping balance productivity across all aspects of your life.

---

## Overview

Multitudes is a next-generation personal assistant that understands you're not a single, monolithic entity. You have different modes, energy levels, and priorities depending on context. Multitudes helps you:

- **Discover Your Personas**: Identify the different "voices" or modes you operate in
- **Balance Your Life**: Ensure all aspects of yourself are appropriately served
- **Optimize Your Time**: Schedule tasks when you have the right energy for them
- **Learn and Adapt**: The system improves its understanding of you over time

## Features

### Core Capabilities (v2.0)
- 🎭 **Persona Management**: Define and track multiple personas with unique attributes
- ✅ **Intelligent Task Management**: Tasks assigned to appropriate personas
- 📊 **Balance Dashboard**: Visualize which personas need attention
- 📧 **Data Integration**: Sync with Apple Mail, Calendar, and more
- 🤖 **AI Insights**: Pattern recognition and personalized recommendations
- 📈 **Energy Tracking**: Monitor and predict your energy levels over time

### Upcoming Features (v2.1+)
- 🔄 **Outlook & Gmail Integration**: Full support for all major email/calendar platforms
- 🧠 **Advanced Learning**: Automatic persona detection and adjustments
- 📱 **Mobile App**: Cross-platform iOS and Android companion app
- 🎯 **Task Routing**: Automatic assignment based on persona patterns

## Installation

### Prerequisites
- Python 3.11 or higher
- PostgreSQL 15+
- InfluxDB 2.x
- Docker & Docker Compose (recommended)

### Quick Start with Docker

```bash
# Clone the repository
git clone https://github.com/yourusername/multitudes.git
cd multitudes

# Copy environment template
cp .env.example .env

# Edit .env with your settings
nano .env

# Start all services
docker-compose up -d

# Access the dashboard
open http://localhost:8501
```

### Manual Installation

```bash
# Create virtual environment
python -m venv .venv
source .venv/bin/activate  # On Mac/Linux
# or
.venv\Scripts\activate  # On Windows

# Install dependencies
pip install -r requirements.txt

# Set up databases
python scripts/init_db.py

# Run database migrations
alembic upgrade head

# Start the API server
uvicorn src.api.main:app --reload

# In another terminal, start the web dashboard
streamlit run src/web/app.py
```

## Configuration

### Environment Variables

Copy `.env.example` to `.env` and configure:

```bash
# Database Configuration
DATABASE_URL=postgresql://user:password@localhost:5432/multitudes
INFLUXDB_URL=http://localhost:8086
INFLUXDB_TOKEN=your-token-here
INFLUXDB_ORG=multitudes
INFLUXDB_BUCKET=multitudes-data

# API Keys
OPENAI_API_KEY=sk-...

# Security
JWT_SECRET_KEY=generate-a-secure-key
JWT_ALGORITHM=HS256

# Apple Integration
APPLE_MAIL_ENABLED=true
APPLE_CALENDAR_ENABLED=true

# Optional: External Services
OUTLOOK_CLIENT_ID=your-client-id
OUTLOOK_CLIENT_SECRET=your-client-secret
GMAIL_CLIENT_ID=your-client-id
GMAIL_CLIENT_SECRET=your-client-secret
```

## Usage

### First Time Setup

1. **Launch the Dashboard**: Navigate to http://localhost:8501
2. **Create Your Account**: Register with email
3. **Persona Discovery Wizard**: Interactive process to identify your personas
4. **Connect Data Sources**: Link your email and calendar accounts
5. **Initial Sync**: Let the system analyze your existing data

### Daily Workflow

1. **Morning Review**: Check your persona balance and today's focus
2. **Task Management**: View recommended tasks based on current energy/context
3. **Complete Tasks**: Mark tasks done as you go
4. **End of Day**: Review accomplishments and adjust tomorrow's plan

### Key Concepts

#### Personas
Personas represent different aspects of yourself. Examples:
- **Professional**: Work-focused, analytical, high-energy
- **Creative**: Artistic, exploratory, requires quiet time
- **Social**: People-focused, energized by interaction
- **Maintenance**: Routine tasks, administrative work
- **Learning**: Study, research, skill development

Each persona has:
- Energy patterns (when you're best at this mode)
- Preferred task types
- Color coding and icons for easy recognition

#### Energy Levels
The system tracks and predicts your energy levels (1-5 scale) throughout the day, helping schedule high-energy tasks when you're most capable.

#### Task Routing
Tasks are automatically assigned to the most appropriate persona based on:
- Task content and type
- Historical patterns
- Energy requirements
- Dependencies

## API Documentation

API documentation is auto-generated and available at:
- **OpenAPI/Swagger**: http://localhost:8000/docs
- **ReDoc**: http://localhost:8000/redoc

### Example API Usage

```python
import requests

# Authenticate
response = requests.post('http://localhost:8000/api/v1/auth/login', 
                        json={'email': 'user@example.com', 'password': 'password'})
token = response.json()['access_token']

# Get personas
headers = {'Authorization': f'Bearer {token}'}
personas = requests.get('http://localhost:8000/api/v1/personas', headers=headers)

# Create a task
task = {
    'title': 'Review quarterly report',
    'persona_id': 'professional-persona-id',
    'priority': 4,
    'energy_required': 4
}
requests.post('http://localhost:8000/api/v1/tasks', json=task, headers=headers)
```

## Development

### Project Structure

```
multitudes/
├── docs/              # Documentation
├── src/               # Source code
│   ├── api/          # FastAPI backend
│   ├── core/         # Domain logic
│   ├── extractors/   # Data source integrations
│   ├── shared/       # Utilities
│   └── web/          # Streamlit dashboard
├── tests/            # Test suite
└── alembic/          # Database migrations
```

### Running Tests

```bash
# Run all tests
pytest

# Run with coverage
pytest --cov=src --cov-report=html

# Run specific test file
pytest tests/unit/test_personas.py

# Run with output
pytest -v -s
```

### Code Quality

```bash
# Linting
ruff check src/

# Type checking
mypy src/

# Format code
ruff format src/
```

### Database Migrations

```bash
# Create a new migration
alembic revision --autogenerate -m "Description of changes"

# Apply migrations
alembic upgrade head

# Rollback last migration
alembic downgrade -1
```

## Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'feat: add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Commit Convention

We follow [Conventional Commits](https://www.conventionalcommits.org/):
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `test:` Test additions/modifications
- `refactor:` Code refactoring
- `chore:` Maintenance tasks

## Architecture

For detailed architecture information, see [ARCHITECTURE.md](docs/ARCHITECTURE.md).

Key architectural decisions:
- **Persona-Centric Design**: Everything revolves around user personas
- **API-First**: REST API enables future mobile apps
- **Multiple Databases**: PostgreSQL for relational, InfluxDB for time-series
- **Modular Extractors**: Easy to add new data sources
- **Type-Safe Python**: Extensive use of type hints and Pydantic models

## Troubleshooting

### Common Issues

**Database Connection Errors**
```bash
# Verify PostgreSQL is running
pg_isready -h localhost -p 5432

# Check connection string in .env
echo $DATABASE_URL
```

**API Not Starting**
```bash
# Check port availability
lsof -i :8000

# View logs
docker-compose logs api
```

**Data Sync Issues**
- Verify credentials in `.env`
- Check API quotas for external services
- Review sync logs in dashboard

## License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file for details.

## Acknowledgments

- Inspired by Walt Whitman's "Song of Myself"
- Built with FastAPI, Streamlit, and PostgreSQL
- AI capabilities powered by OpenAI

## Support

- 📧 Email: support@multitudes.app (coming soon)
- 📖 Documentation: [docs.multitudes.app](https://docs.multitudes.app) (coming soon)
- 🐛 Issues: [GitHub Issues](https://github.com/yourusername/multitudes/issues)

---

**Version**: 2.0.0  
**Last Updated**: 2025-12-08  
**Status**: Initial Release
