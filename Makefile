.PHONY: all up down clean rebuild logs shell-db shell-backend certs seed help

# Default
all: help

# Start everything
up:
	docker compose up -d

# Start with logs visible
up-logs:
	docker compose up

# Stop everything
down:
	docker compose down

# Stop and wipe volumes (full reset including DB data)
clean:
	docker compose down -v

# Rebuild backend image and restart
rebuild:
	docker compose down
	docker compose build --no-cache backend
	docker compose up -d

# View logs
logs:
	docker compose logs -f

logs-backend:
	docker compose logs -f backend

logs-db:
	docker compose logs -f db

logs-nginx:
	docker compose logs -f nginx

# Shell access
shell-db:
	docker compose exec db mariadb -u root -p course_registration

shell-backend:
	docker compose exec backend sh

shell-nginx:
	docker compose exec nginx sh

# Generate self-signed SSL certs
certs:
	mkdir -p nginx/certs
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout nginx/certs/key.pem \
		-out nginx/certs/cert.pem \
		-subj "/C=LB/ST=Beirut/L=Beirut/O=LAU/CN=localhost"
	@echo "Certs generated in nginx/certs/"

# Generate secrets
secrets:
	mkdir -p secrets
	@read -p "DB password: " pw; echo $$pw > secrets/db_password.txt
	@read -p "DB username: " un; echo $$un > secrets/db_username.txt
	openssl rand -base64 64 > secrets/jwt_secret.txt
	@echo "Secrets generated in secrets/"

# Full first-time setup
setup: certs secrets up

# Help
help:
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "  setup        First time setup (certs + secrets + up)"
	@echo "  up           Start all containers (detached)"
	@echo "  up-logs      Start all containers (with logs)"
	@echo "  down         Stop all containers"
	@echo "  clean        Stop and wipe all volumes"
	@echo "  rebuild      Rebuild backend and restart"
	@echo "  logs         Follow all logs"
	@echo "  logs-backend Follow backend logs"
	@echo "  logs-db      Follow db logs"
	@echo "  logs-nginx   Follow nginx logs"
	@echo "  shell-db     Open MariaDB shell"
	@echo "  shell-backend Open backend shell"
	@echo "  certs        Generate self-signed SSL certs"
	@echo "  secrets      Generate secrets folder"
	@echo ""