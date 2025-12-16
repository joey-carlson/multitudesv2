#!/bin/bash

# Run FastAPI application on port 2701

echo "🚀 Starting Multitudes API on port 2701..."
echo ""

cd "$(dirname "$0")/.."

if [ ! -d ".venv" ]; then
    echo "❌ Virtual environment not found!"
    echo "Run ./scripts/setup.sh first"
    exit 1
fi

source .venv/bin/activate

echo "Starting API server..."
echo "Access at: http://localhost:2701"
echo "API docs at: http://localhost:2701/docs"
echo ""

python -m uvicorn src.api.app:app --host 0.0.0.0 --port 2701 --reload
