.PHONY: all up down clean rebuild re logs shell-db shell-backend shell-nginx shell-frontend certs secrets setup help fclean

all: help

up:
	docker compose up -d

up-logs:
	docker compose up

down:
	docker compose down

clean:
	docker compose down -v

fclean:
	docker compose down -v --rmi all --remove-orphans

re:
	docker compose down
	docker compose build --no-cache
	docker compose up -d

re-backend:
	docker compose down backend
	docker compose build --no-cache backend
	docker compose up -d backend

re-frontend:
	docker compose down frontend
	docker compose build --no-cache frontend
	docker compose up -d frontend

logs:
	docker compose logs -f

logs-backend:
	docker compose logs -f backend

logs-db:
	docker compose logs -f db

logs-nginx:
	docker compose logs -f nginx

logs-frontend:
	docker compose logs -f frontend

shell-db:
	docker compose exec db mariadb -u root -p course_registration

shell-backend:
	docker compose exec backend sh

shell-nginx:
	docker compose exec nginx sh

shell-frontend:
	docker compose exec frontend sh

certs:
	mkdir -p nginx/certs
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout nginx/certs/key.pem \
		-out nginx/certs/cert.pem \
		-subj "/C=LB/ST=Beirut/L=Beirut/O=LAU/CN=registration.lau.local"
	@echo "Certs generated in nginx/certs/"

secrets:
	mkdir -p secrets
	echo "root" > secrets/db_password.txt
	echo "root" > secrets/db_username.txt
	openssl rand -base64 64 > secrets/jwt_secret.txt
	@echo "Secrets generated in secrets/"

setup: certs secrets up

help:
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "  setup          First time setup (certs + secrets + up)"
	@echo "  up             Start all containers (detached)"
	@echo "  up-logs        Start all containers (with logs)"
	@echo "  down           Stop all containers"
	@echo "  clean          Stop and wipe all volumes"
	@echo "  fclean         Stop, wipe volumes and remove all images"
	@echo "  re             Rebuild everything and restart"
	@echo "  re-backend     Rebuild only backend"
	@echo "  re-frontend    Rebuild only frontend"
	@echo "  logs           Follow all logs"
	@echo "  logs-backend   Follow backend logs"
	@echo "  logs-db        Follow db logs"
	@echo "  logs-nginx     Follow nginx logs"
	@echo "  logs-frontend  Follow frontend logs"
	@echo "  shell-db       Open MariaDB shell"
	@echo "  shell-backend  Open backend shell"
	@echo "  shell-nginx    Open nginx shell"
	@echo "  shell-frontend Open frontend shell"
	@echo "  certs          Generate self-signed SSL certs"
	@echo "  secrets        Generate secrets folder"
	@echo ""