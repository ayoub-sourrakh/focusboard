# 🐳 Docker Quick Start

## ⚡ Start in 3 Commands

```bash
# 1. Build and start
docker-compose up --build -d

# 2. Setup database
docker-compose exec web rails db:create db:migrate

# 3. Open browser
open http://localhost:3000
```

---

## 🛑 Stop

```bash
docker-compose down
```

---

## 📝 Useful Commands

```bash
# View logs
docker-compose logs -f

# Rails console
docker-compose exec web rails console

# Run migrations
docker-compose exec web rails db:migrate

# Restart services
docker-compose restart
```

---

**That's it! 🚀**

For more details, see [DOCKER_SETUP.md](DOCKER_SETUP.md)
