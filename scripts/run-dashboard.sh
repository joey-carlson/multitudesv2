#!/bin/zsh

# Run Streamlit dashboard on port 8502

echo "🎨 Starting Multitudes Dashboard on port 8502..."
echo ""

cd "$(dirname "$0")/.."

if [ ! -d ".venv" ]; then
    echo "❌ Virtual environment not found!"
    echo "Run ./scripts/setup.sh first"
    exit 1
fi

source .venv/bin/activate

echo "Starting Streamlit dashboard..."
echo "Access at: http://localhost:8502"
echo ""
echo "⚠️  Make sure the API is running on port 8001!"
echo "   Run ./scripts/run-api.sh in another terminal"
echo ""

streamlit run src/web/streamlit_app.py --server.port 8502 --server.address localhost
