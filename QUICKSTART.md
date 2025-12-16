# Multitudes v2.0 - Quick Start Guide

🚀 **Get up and running in 5 minutes!**

## What is Multitudes?

An AI personal assistant with **adaptive personalization** that learns from your behavior patterns, preferences, and feedback. Each user gets isolated context that improves over time through continuous learning.

**Phase 1 (Current):** Adaptive prompts - AI personalization without expensive model fine-tuning  
**Cost:** $1-3/user/month vs $25-60 for model training  
**Benefit:** 80% of fine-tuning effectiveness at 5% of the cost

---

## Prerequisites

- Python 3.9+
- Git

---

## Setup (One-Time)

### 0. Install & Start Docker Desktop

Docker is required to run PostgreSQL, InfluxDB, and Redis.

**Install Docker Desktop:**

**On macOS:**
1. Download Docker Desktop from https://www.docker.com/products/docker-desktop/
2. Open the downloaded .dmg file
3. Drag Docker to Applications folder
4. Open Docker from Applications
5. Wait for Docker to start (Docker icon appears in menu bar)

**On Linux:**
```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install docker.io docker-compose
sudo systemctl start docker
sudo systemctl enable docker

# Add your user to docker group (to run without sudo)
sudo usermod -aG docker $USER
# Log out and back in for this to take effect
```

**On Windows:**
1. Download Docker Desktop from https://www.docker.com/products/docker-desktop/
2. Run the installer
3. Restart your computer if prompted
4. Start Docker Desktop from Start menu

**Verify Docker is Running:**
```bash
docker --version
docker-compose --version
docker ps
```

You should see version numbers and no errors. The `docker ps` command should show an empty list (or running containers if you have any).

**If Docker Desktop won't start:**
- On macOS: Check System Preferences > Security & Privacy
- On Windows: Ensure virtualization is enabled in BIOS
- On all platforms: Check Docker Desktop logs in the app

### 1. Start Docker Services & Database

```bash
cd /Users/joecrls/Documents/Code/Multitudesv2

# Start Docker services (PostgreSQL, InfluxDB, Redis)
./scripts/start-dev.sh
```

This will:
- ✅ Check Docker is running
- ✅ Start database services
- ✅ Wait for PostgreSQL to be ready
- ✅ Run database migrations

### 2. Install Dependencies (if not done)

```bash
./scripts/setup.sh
```

---

## Running the Application

You need **two terminal windows**:

### Terminal 1: Start API Server (Port 2701)

```bash
cd /Users/joecrls/Documents/Code/Multitudesv2
./scripts/run-api.sh
```

You should see:
```
🚀 Starting Multitudes API on port 2701...
✅ Storage backend initialized
```

**API Documentation:** http://localhost:2701/docs

### Terminal 2: Start Dashboard (Port 2700)

```bash
cd /Users/joecrls/Documents/Code/Multitudesv2
./scripts/run-dashboard.sh
```

You should see:
```
🎨 Starting Multitudes Dashboard on port 2700...

  You can now view your Streamlit app in your browser.
  Local URL: http://localhost:2700
```

**Dashboard:** http://localhost:2700

---

## Testing Multi-User Context Isolation

### Test Passphrases

Use these pre-configured passphrases to test different users:

```
purple-monkey-dishwasher  →  Test User 1
correct-horse-battery     →  Test User 2
flying-toaster-banana     →  Test User 3
cosmic-panda-sunrise      →  Test User 4
quantum-dolphin-jazz      →  Test User 5
```

### Test Scenario: Context Isolation

**Objective:** Verify that each user sees completely different context.

1. **Open Dashboard in Browser 1**
   - Go to http://localhost:2700
   - Login with: `purple-monkey-dishwasher`
   - Add context:
     - Type: `preference`
     - Key: `work_style`
     - Value: `"analytical"`
   - Add pattern:
     - Type: `pattern`
     - Key: `morning_person`
     - Value: `"Prefers 9am start time"`

2. **Open Dashboard in Browser 2 (or Incognito)**
   - Go to http://localhost:2700
   - Login with: `correct-horse-battery`
   - Add DIFFERENT context:
     - Type: `preference`
     - Key: `work_style`
     - Value: `"creative"`
   - Add pattern:
     - Type: `pattern`
     - Key: `night_owl`
     - Value: `"Prefers evening work sessions"`

3. **Verify Isolation**
   - Check "Context Overview" tab in each browser
   - User 1 should ONLY see "analytical" and morning patterns
   - User 2 should ONLY see "creative" and evening patterns
   - ✅ Context is properly isolated per user!

### Test Scenario: Learning Loop

**Objective:** Verify the system learns from feedback.

1. **Login as Test User 1**

2. **Add Initial Context**
   - Preference: `energy_level` = `"high in morning"`

3. **Submit Feedback (Accept)**
   - Go to "Submit Feedback" tab
   - Interaction Type: `task_suggestion`
   - Feedback Type: `accepted`
   - Interaction Data: `{"task": "coding", "time": "09:00"}`
   - Feedback Data: `{"reason": "good timing"}`

4. **Check Statistics**
   - Go to "Statistics" tab
   - Should see context count increased
   - Check "By Source" - should show `feedback` entries

5. **Verify Pattern Learning**
   - System should strengthen confidence in morning preferences
   - Check context overview for updated patterns

---

## API Usage Examples

### Authentication

```bash
# Login
curl -X POST http://localhost:2701/auth/login \
  -H "Content-Type: application/json" \
  -d '{"passphrase": "purple-monkey-dishwasher"}'

# Response:
# {
#   "access_token": "eyJ0eXAiOiJKV1QiLCJhbGc...",
#   "token_type": "bearer",
#   "user_id": "test_user_001",
#   "display_name": "Test User 1"
# }

# Use token in subsequent requests
export TOKEN="your_access_token_here"

# Get current user
curl http://localhost:2701/auth/me \
  -H "Authorization: Bearer $TOKEN"
```

### Context Management

```bash
# Get user context
curl http://localhost:2701/api/context \
  -H "Authorization: Bearer $TOKEN"

# Add context
curl -X POST http://localhost:2701/api/context \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "context_type": "preference",
    "key": "work_style",
    "value": "analytical",
    "confidence": 0.9
  }'

# Get statistics
curl http://localhost:2701/api/context/stats \
  -H "Authorization: Bearer $TOKEN"
```

### Submit Feedback

```bash
curl -X POST http://localhost:2701/api/feedback \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "interaction_type": "task_suggestion",
    "interaction_data": {"task": "Write code", "time": "09:00"},
    "feedback_type": "accepted",
    "feedback_data": {"reason": "Perfect timing"}
  }'
```

---

## Architecture Overview

```
┌──────────────────────────────────────┐
│   Streamlit Dashboard (Port 2700)   │
│   - Login interface                  │
│   - Context viewing                  │
│   - Feedback submission              │
└─────────────┬────────────────────────┘
              │ HTTP/REST
              ↓
┌──────────────────────────────────────┐
│     FastAPI Server (Port 2701)       │
│   - JWT Authentication               │
│   - Context API                      │
│   - Feedback processing              │
└─────────────┬────────────────────────┘
              │
              ↓
┌──────────────────────────────────────┐
│    Context Manager & Learning        │
│   - Time-decay weighting             │
│   - Pattern detection                │
│   - Feedback loops                   │
└─────────────┬────────────────────────┘
              │
              ↓
┌──────────────────────────────────────┐
│   PostgreSQL (Port 5432)             │
│   - Users & auth                     │
│   - Context storage                  │
│   - Feedback tracking                │
└──────────────────────────────────────┘
```

---

## Key Features

### ✅ Multi-User Isolation
- Each user gets unique context
- Complete data separation
- Individual learning paths

### ✅ Time-Decay Weighting
- Recent context: 100% weight
- 1-month old: 70% weight
- 3-months old: 40% weight
- Older: 20% (never deleted)

### ✅ Continuous Learning
- Accept/reject feedback
- Pattern strengthening
- Confidence adjustment
- Automatic adaptation

### ✅ Privacy-First
- Local database by default
- User-controlled data
- Transparent learning
- No external API calls

---

## Troubleshooting

### Port Already in Use

If you see "Address already in use":

```bash
# Find process using port 2700 or 2701
lsof -i :2700
lsof -i :2701

# Kill the process
kill -9 <PID>

# Or use different ports by editing the scripts
```

### Docker Not Running

```
❌ Docker is not running!
```

**Solution:** Open Docker Desktop application

### Database Connection Error

```
sqlalchemy.exc.OperationalError: connection to server failed
```

**Solution:**
1. Ensure Docker is running
2. Run `./scripts/start-dev.sh` to start PostgreSQL
3. Wait for "PostgreSQL is ready" message

### Import Errors

```
ModuleNotFoundError: No module named 'fastapi'
```

**Solution:**
```bash
source .venv/bin/activate
pip install -r requirements.txt
```

---

## What's Next?

### Phase 2: RAG + Vector Search (Future)
- Semantic search across historical context
- Deeper personalization
- Cost: $2-5/user/month

### Phase 3: Local/Edge Learning (Future)
- On-device AI (Llama 3.2 1B)
- Full offline capability
- Cost: $0.50/user/month

---

## Support

- **Documentation:** `docs/REQUIREMENTS.md`, `docs/ARCHITECTURE.md`
- **API Docs:** http://localhost:2701/docs (when running)
- **Git History:** `git log --oneline`

---

## Quick Commands Reference

```bash
# Start everything
./scripts/start-dev.sh          # Docker + DB migrations
./scripts/run-api.sh             # API server (2701)
./scripts/run-dashboard.sh       # Dashboard (2700)

# Check status
docker-compose ps                # Service status
docker-compose logs -f           # View logs

# Stop services
docker-compose down              # Stop Docker services
# Ctrl+C in terminal             # Stop API/Dashboard

# Database
alembic upgrade head             # Run migrations
alembic downgrade -1             # Rollback migration
```

---

**Ready to test!** 🎉

Login at http://localhost:2700 with any test passphrase and start exploring adaptive personalization!
