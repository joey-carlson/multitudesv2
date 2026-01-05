#!/bin/zsh

# Run FastAPI application on port 8001

echo "🚀 Starting Multitudes API on port 8001..."
echo ""

cd "$(dirname "$0")/.."

if [ ! -d ".venv" ]; then
    echo "❌ Virtual environment not found!"
    echo "Run ./scripts/setup.sh first"
    exit 1
fi

source .venv/bin/activate

echo "Starting API server..."
echo "Access at: http://localhost:8001"
echo "API docs at: http://localhost:8001/docs"
echo ""

python -m uvicorn src.api.app:app --host 0.0.0.0 --port 8001 --reload
