# 🐳 Docker Setup Guide

## 📋 Prerequisites

- Docker installed
- Docker Compose installed

## 🚀 Quick Start

### 1. Build and start all services

```bash
docker-compose up --build
```

This will:
- Build the Docker images
- Start PostgreSQL database
- Start Rails web server
- Start Tailwind CSS watcher

### 2. Setup database (first time only)

In a new terminal:

```bash
# Create database
docker-compose exec web rails db:create

# Run migrations
docker-compose exec web rails db:migrate

# (Optional) Seed data
docker-compose exec web rails db:seed
```

### 3. Access the application

Open your browser: **http://localhost:3000**

---

## 🛠️ Common Commands

### Start services
```bash
docker-compose up
```

### Start in background
```bash
docker-compose up -d
```

### Stop services
```bash
docker-compose down
```

### View logs
```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f web
docker-compose logs -f db
docker-compose logs -f css
```

### Rebuild images
```bash
docker-compose build
```

### Run Rails commands
```bash
# Rails console
docker-compose exec web rails console

# Run migrations
docker-compose exec web rails db:migrate

# Create migration
docker-compose exec web rails generate migration AddFieldToModel

# Run tests
docker-compose exec web rails test
```

### Bundle install (after adding gems)
```bash
docker-compose exec web bundle install
docker-compose restart web
```

### Access Rails console
```bash
docker-compose exec web rails console
```

### Access PostgreSQL
```bash
docker-compose exec db psql -U postgres -d focusboard_development
```

---

## 📁 Docker Files

### `Dockerfile` (Production)
- Multi-stage build
- Optimized for production
- Used by Kamal for deployment

### `Dockerfile.dev` (Development)
- Simpler setup
- Includes dev dependencies
- Used by docker-compose

### `docker-compose.yml`
Defines 3 services:
- **db**: PostgreSQL 16
- **web**: Rails server (port 3000)
- **css**: Tailwind CSS watcher

---

## 🔧 Configuration

### Database Connection

The database connection is configured via environment variable in `docker-compose.yml`:

```yaml
DATABASE_URL: postgresql://postgres:postgres@db:5432/focusboard_development
```

### Volumes

- **postgres_data**: Persists database data
- **bundle_cache**: Caches Ruby gems
- **.:/rails**: Mounts your code (hot reload)

---

## 🐛 Troubleshooting

### Port already in use
```bash
# Stop conflicting services
sudo lsof -ti:3000 | xargs kill -9
sudo lsof -ti:5432 | xargs kill -9
```

### Database connection error
```bash
# Restart database
docker-compose restart db

# Check database health
docker-compose ps
```

### Permission errors
```bash
# Fix file permissions
sudo chown -R $USER:$USER .
```

### Clean everything and restart
```bash
# Stop and remove everything
docker-compose down -v

# Rebuild and start
docker-compose up --build

# Recreate database
docker-compose exec web rails db:create db:migrate
```

### Tailwind not compiling
```bash
# Restart CSS service
docker-compose restart css

# Check CSS logs
docker-compose logs -f css
```

---

## 🎯 Development Workflow

### 1. Start Docker
```bash
docker-compose up
```

### 2. Make code changes
Your changes are automatically reflected (hot reload)

### 3. Run migrations if needed
```bash
docker-compose exec web rails db:migrate
```

### 4. Restart if needed
```bash
docker-compose restart web
```

---

## 🚀 Production Deployment

For production, use the main `Dockerfile` with Kamal:

```bash
# Deploy with Kamal
kamal deploy
```

Or build manually:

```bash
# Build production image
docker build -t focusboard .

# Run production container
docker run -d -p 80:80 \
  -e RAILS_MASTER_KEY=<your_key> \
  -e DATABASE_URL=<your_db_url> \
  --name focusboard \
  focusboard
```

---

## ✅ Services Overview

| Service | Port | Description |
|---------|------|-------------|
| web | 3000 | Rails application |
| db | 5432 | PostgreSQL database |
| css | - | Tailwind CSS compiler |

---

## 📊 Resource Usage

Typical resource usage:
- **RAM**: ~500MB (all services)
- **Disk**: ~2GB (images + volumes)
- **CPU**: Low (idle), Medium (compiling)

---

**Docker setup complete! 🐳✨**
