#!/bin/zsh

# Multitudes Development Environment Startup Script
# This script starts Docker services and runs database migrations

set -e  # Exit on error

echo "🚀 Starting Multitudes Development Environment..."
echo ""

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_ROOT"

# Check if Docker is running
echo "📦 Checking Docker status..."
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running!"
    echo "Please start Docker Desktop and try again."
    echo ""
    echo "On macOS: Open Docker Desktop from Applications"
    exit 1
fi
echo "✅ Docker is running"
echo ""

# Start Docker Compose services
echo "🐳 Starting Docker services..."
docker-compose up -d

# Wait for PostgreSQL to be ready
echo "⏳ Waiting for PostgreSQL to be ready..."
MAX_TRIES=30
TRIES=0
until docker-compose exec -T postgres pg_isready -U multitudes > /dev/null 2>&1; do
    TRIES=$((TRIES+1))
    if [ $TRIES -eq $MAX_TRIES ]; then
        echo "❌ PostgreSQL failed to start after ${MAX_TRIES} seconds"
        echo "Check logs with: docker-compose logs postgres"
        exit 1
    fi
    echo "   Still waiting... (${TRIES}/${MAX_TRIES})"
    sleep 1
done
echo "✅ PostgreSQL is ready"
echo ""

# Activate virtual environment and run migrations
echo "🔄 Running database migrations..."
if [ -d ".venv" ]; then
    source .venv/bin/activate
    alembic upgrade head
    echo "✅ Migrations complete"
else
    echo "⚠️  Virtual environment not found. Run ./scripts/setup.sh first"
    exit 1
fi
echo ""

# Show service status
echo "📊 Service Status:"
docker-compose ps
echo ""

echo "✨ Development environment is ready!"
echo ""
echo "Service URLs:"
echo "  PostgreSQL: postgresql://multitudes:multitudes@localhost:5432/multitudes_db"
echo "  InfluxDB:   http://localhost:8086"
echo "  Redis:      redis://localhost:6379"
echo ""
echo "Useful commands:"
echo "  docker-compose ps              # Check service status"
echo "  docker-compose logs -f         # View logs"
echo "  docker-compose down            # Stop services"
echo "  alembic upgrade head           # Run migrations"
echo "  alembic downgrade -1           # Rollback one migration"
echo ""
