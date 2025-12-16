#!/bin/bash

# Run Streamlit dashboard on port 2700

echo "🎨 Starting Multitudes Dashboard on port 2700..."
echo ""

cd "$(dirname "$0")/.."

if [ ! -d ".venv" ]; then
    echo "❌ Virtual environment not found!"
    echo "Run ./scripts/setup.sh first"
    exit 1
fi

source .venv/bin/activate

echo "Starting Streamlit dashboard..."
echo "Access at: http://localhost:2700"
echo ""
echo "⚠️  Make sure the API is running on port 2701!"
echo "   Run ./scripts/run-api.sh in another terminal"
echo ""

streamlit run src/web/streamlit_app.py --server.port 2700 --server.address localhost
