#!/bin/bash
# Multitudes v2.0 - Development Environment Setup Script

set -e  # Exit on error

echo "🧠 Multitudes v2.0 - Development Environment Setup"
echo "=================================================="
echo ""

# Check if we're in the project root
if [ ! -f "pyproject.toml" ]; then
    echo "❌ Error: Please run this script from the project root directory"
    exit 1
fi

# Check for Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Error: Docker is not installed. Please install Docker Desktop for Mac."
    exit 1
fi

# Check for Python 3.11+
if ! command -v python3 &> /dev/null; then
    echo "❌ Error: Python 3 is not installed"
    exit 1
fi

PYTHON_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
echo "✅ Found Python $PYTHON_VERSION"

# Create virtual environment
echo ""
echo "📦 Creating virtual environment..."
if [ -d ".venv" ]; then
    echo "⚠️  Virtual environment already exists. Skipping creation."
else
    python3 -m venv .venv
    echo "✅ Virtual environment created"
fi

# Activate virtual environment
echo ""
echo "🔌 Activating virtual environment..."
source .venv/bin/activate

# Upgrade pip
echo ""
echo "⬆️  Upgrading pip..."
pip install --upgrade pip setuptools wheel

# Install dependencies
echo ""
echo "📚 Installing dependencies..."
pip install -r requirements-dev.txt

echo "✅ Dependencies installed"

# Create .env file if it doesn't exist
echo ""
if [ -f ".env" ]; then
    echo "⚠️  .env file already exists. Skipping creation."
else
    echo "📝 Creating .env file from template..."
    cp .env.example .env
    echo "✅ .env file created. Please update with your settings."
    echo "   Edit: .env"
fi

# Create logs directory
echo ""
echo "📁 Creating logs directory..."
mkdir -p logs
echo "✅ Logs directory created"

# Start Docker services
echo ""
echo "🐳 Starting Docker services..."
docker-compose up -d

echo ""
echo "⏳ Waiting for services to be healthy..."
sleep 10

# Check service health
echo ""
echo "🏥 Checking service health..."
docker-compose ps

echo ""
echo "✅ Docker services started:"
echo "   - PostgreSQL: localhost:5432"
echo "   - InfluxDB:   localhost:8086"
echo "   - Redis:      localhost:6379"

# Run database migrations
echo ""
echo "🗄️  Running database migrations..."
if [ -d "alembic/versions" ] && [ "$(ls -A alembic/versions)" ]; then
    alembic upgrade head
    echo "✅ Database migrations applied"
else
    echo "⚠️  No migrations found yet. Run 'alembic revision --autogenerate -m \"initial\"' to create first migration."
fi

echo ""
echo "=================================================="
echo "✨ Setup complete! ✨"
echo ""
echo "Next steps:"
echo "  1. Activate virtual environment: source .venv/bin/activate"
echo "  2. Edit .env file with your settings"
echo "  3. Start development:"
echo "     - API:       uvicorn src.api.main:app --reload"
echo "     - Dashboard: streamlit run src/web/app.py"
echo ""
echo "Useful commands:"
echo "  - Stop services:    docker-compose down"
echo "  - View logs:        docker-compose logs -f"
echo "  - Run tests:        pytest"
echo "  - Check types:      mypy src/"
echo "  - Lint code:        ruff check src/"
echo ""
