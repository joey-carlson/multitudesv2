# Docker Guide for Multitudes v2.0

**Version:** 2.0.0  
**Last Updated:** 2025-12-09  
**Audience:** Developers new to Docker

---

## What is Docker? 🐳

Docker is a platform that packages applications and their dependencies into isolated containers. Think of containers as lightweight, portable "boxes" that contain everything needed to run an application.

### Key Concepts

**Container**: A running instance of an image. Like a virtual machine but much lighter.
- Isolated from your Mac's system
- Has its own filesystem, network, and processes
- Can be started, stopped, and removed easily

**Image**: A blueprint for containers. Contains the application and dependencies.
- Like a recipe that describes what goes in the container
- Downloaded from Docker Hub (like an app store for containers)

**Volume**: Persistent storage for containers.
- Data survives even when containers are deleted
- Shared between your Mac and the container

**Network**: Allows containers to talk to each other.
- Containers can communicate via service names
- Isolated from your Mac's network

---

## Why We Use Docker for Multitudes

Instead of installing PostgreSQL, InfluxDB, and Redis directly on your Mac, we use Docker to:

1. **Avoid Version Conflicts**: Your Mac stays clean
2. **Easy Setup**: One command starts everything
3. **Reproducible Environment**: Works the same on any machine
4. **Easy Cleanup**: Delete containers without affecting your Mac

---

## Docker Desktop for Mac

### Installation

1. Download Docker Desktop from: https://www.docker.com/products/docker-desktop/
2. Install the .dmg file
3. Launch Docker Desktop
4. Wait for the whale icon to appear in your menu bar (means Docker is running)

### Verify Installation

```bash
docker --version
docker-compose --version
```

You should see version numbers for both commands.

---

## Understanding docker-compose.yml

Our `docker-compose.yml` file defines three services:

### 1. PostgreSQL (postgres)
```yaml
postgres:
  image: postgres:15-alpine        # Use PostgreSQL 15 (lightweight version)
  container_name: multitudes-postgres
  environment:                     # Configuration
    POSTGRES_USER: multitudes
    POSTGRES_PASSWORD: multitudes_dev_password
    POSTGRES_DB: multitudes_db
  ports:
    - "5432:5432"                  # Mac port : Container port
  volumes:
    - postgres_data:/var/lib/postgresql/data  # Persistent storage
```

**What it does**: Runs PostgreSQL database for storing users, personas, and tasks.

### 2. InfluxDB (influxdb)
```yaml
influxdb:
  image: influxdb:2.7-alpine
  container_name: multitudes-influxdb
  environment:
    DOCKER_INFLUXDB_INIT_MODE: setup
    DOCKER_INFLUXDB_INIT_USERNAME: multitudes
    DOCKER_INFLUXDB_INIT_PASSWORD: multitudes_dev_password
    DOCKER_INFLUXDB_INIT_ORG: multitudes
    DOCKER_INFLUXDB_INIT_BUCKET: multitudes-data
    DOCKER_INFLUXDB_INIT_ADMIN_TOKEN: multitudes-dev-token-change-in-production
  ports:
    - "8086:8086"
```

**What it does**: Runs InfluxDB for time-series data (energy levels, task metrics).

### 3. Redis (redis)
```yaml
redis:
  image: redis:7-alpine
  container_name: multitudes-redis
  ports:
    - "6379:6379"
  volumes:
    - redis_data:/data
  command: redis-server --appendonly yes
```

**What it does**: Runs Redis for caching and background job queue.

---

## Essential Docker Commands

### Starting Services

```bash
# Start all services in background
docker-compose up -d

# Start and see logs in foreground (exit with Ctrl+C)
docker-compose up

# Start specific service
docker-compose up -d postgres
```

### Checking Status

```bash
# See all running containers
docker-compose ps

# See all containers (including stopped)
docker ps -a

# Check container health
docker-compose ps
```

### Viewing Logs

```bash
# See logs from all services
docker-compose logs

# Follow logs in real-time (like tail -f)
docker-compose logs -f

# See logs from specific service
docker-compose logs postgres
docker-compose logs -f influxdb
```

### Stopping Services

```bash
# Stop all services (containers still exist)
docker-compose stop

# Stop specific service
docker-compose stop postgres

# Stop and remove containers (data in volumes is safe)
docker-compose down

# Stop and remove containers AND volumes (⚠️ deletes all data!)
docker-compose down -v
```

### Restarting Services

```bash
# Restart all services
docker-compose restart

# Restart specific service
docker-compose restart postgres
```

### Accessing Container Shell

```bash
# Open PostgreSQL shell
docker exec -it multitudes-postgres psql -U multitudes -d multitudes_db

# Open Redis CLI
docker exec -it multitudes-redis redis-cli

# Open bash shell in container
docker exec -it multitudes-postgres bash
```

### Cleaning Up

```bash
# Remove stopped containers
docker-compose rm

# Remove all stopped containers, unused networks, and dangling images
docker system prune

# See disk usage
docker system df
```

---

## Common Workflows

### Starting Fresh

```bash
cd /Users/joecrls/Documents/Code/Multitudesv2

# Start services
docker-compose up -d

# Check they're running
docker-compose ps

# View startup logs
docker-compose logs
```

### Daily Development

```bash
# Check services are running
docker-compose ps

# If not running, start them
docker-compose up -d

# Work on your code...

# When done for the day (optional - can leave running)
docker-compose stop
```

### Troubleshooting

```bash
# Service won't start?
docker-compose logs <service-name>

# Port already in use?
lsof -i :5432  # Check what's using port 5432
docker-compose down
docker-compose up -d

# Database corrupt?
docker-compose down -v  # ⚠️ Deletes all data!
docker-compose up -d
```

### Resetting Everything

```bash
# Stop and remove everything (keeps volumes)
docker-compose down

# Stop and remove everything including data
docker-compose down -v

# Start fresh
docker-compose up -d
```

---

## Connecting to Databases

### From Python Code

```python
# PostgreSQL (using environment variables from .env)
DATABASE_URL = "postgresql+asyncpg://multitudes:multitudes_dev_password@localhost:5432/multitudes_db"

# InfluxDB
INFLUXDB_URL = "http://localhost:8086"
INFLUXDB_TOKEN = "multitudes-dev-token-change-in-production"
INFLUXDB_ORG = "multitudes"
INFLUXDB_BUCKET = "multitudes-data"

# Redis
REDIS_URL = "redis://localhost:6379/0"
```

### From Command Line Tools

```bash
# PostgreSQL (psql must be installed on your Mac)
psql -h localhost -p 5432 -U multitudes -d multitudes_db

# Or via Docker:
docker exec -it multitudes-postgres psql -U multitudes -d multitudes_db
```

---

## Understanding Ports

When you see `"5432:5432"`:
- **Left side (5432)**: Port on your Mac
- **Right side (5432)**: Port inside the container

Your Python code connects to `localhost:5432`, and Docker forwards it to the container.

---

## Understanding Volumes

Volumes persist data even when containers are deleted:

```yaml
volumes:
  postgres_data:      # Named volume for PostgreSQL data
  influxdb_data:      # Named volume for InfluxDB data
  redis_data:         # Named volume for Redis data
```

**Where is the data?**
- Docker manages it internally
- You don't need to know the exact location
- Use `docker volume ls` to see volumes
- Use `docker volume inspect postgres_data` to see details

---

## Common Issues & Solutions

### Issue: Port Already in Use

```
Error: port 5432 already allocated
```

**Solution**: Another PostgreSQL is running on your Mac
```bash
# Find what's using the port
lsof -i :5432

# Stop the other service or change our port in docker-compose.yml
ports:
  - "5433:5432"  # Use 5433 on Mac instead
```

### Issue: Cannot Connect to Database

**Check 1**: Is the container running?
```bash
docker-compose ps
```

**Check 2**: Is the container healthy?
```bash
docker-compose logs postgres
```

**Check 3**: Wait for initialization
- First startup takes time to initialize database
- Wait 30 seconds and try again

### Issue: "No space left on device"

Docker images/volumes taking up space:
```bash
# Check usage
docker system df

# Clean up
docker system prune -a
docker volume prune
```

---

## Docker Desktop Dashboard

The Docker Desktop app provides a GUI:

1. **Containers**: See running containers, start/stop them
2. **Images**: See downloaded images
3. **Volumes**: See persistent data volumes
4. **Settings**: Configure Docker (memory, disk, etc.)

Look for the whale icon in your Mac menu bar → Open Dashboard

---

## Learning More

- **Official Docker Docs**: https://docs.docker.com/
- **Docker Compose Docs**: https://docs.docker.com/compose/
- **PostgreSQL Image**: https://hub.docker.com/_/postgres
- **InfluxDB Image**: https://hub.docker.com/_/influxdb
- **Redis Image**: https://hub.docker.com/_/redis

---

## Quick Reference Card

```bash
# Start everything
docker-compose up -d

# Check status
docker-compose ps

# View logs
docker-compose logs -f

# Stop everything
docker-compose down

# Reset everything (deletes data!)
docker-compose down -v && docker-compose up -d
```

---

## Next Steps

Now that you understand Docker basics:
1. Run `docker-compose up -d` to start services
2. Check status with `docker-compose ps`
3. View logs with `docker-compose logs -f`
4. Connect your application to the databases

If you have questions or run into issues, the logs usually tell you what's wrong: `docker-compose logs <service-name>`
