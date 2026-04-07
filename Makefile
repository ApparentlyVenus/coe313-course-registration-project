.PHONY: all up down clean rebuild re logs shell-db shell-backend shell-nginx certs secrets setup help fclean

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
	docker compose build --no-cache backend
	docker compose up -d

logs:
	docker compose logs -f

logs-backend:
	docker compose logs -f backend

logs-db:
	docker compose logs -f db

logs-nginx:
	docker compose logs -f nginx

shell-db:
	docker compose exec db mariadb -u root -p course_registration

shell-backend:
	docker compose exec backend sh

shell-nginx:
	docker compose exec nginx sh

certs:
	mkdir -p nginx/certs
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout nginx/certs/key.pem \
		-out nginx/certs/cert.pem \
		-subj "/C=LB/ST=Beirut/L=Beirut/O=LAU/CN=localhost"
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
	@echo "  setup         First time setup (certs + secrets + up)"
	@echo "  up            Start all containers (detached)"
	@echo "  up-logs       Start all containers (with logs)"
	@echo "  down          Stop all containers"
	@echo "  clean         Stop and wipe all volumes"
	@echo "  fclean        Stop, wipe volumes and remove all images"
	@echo "  re            Rebuild backend and restart"
	@echo "  logs          Follow all logs"
	@echo "  logs-backend  Follow backend logs"
	@echo "  logs-db       Follow db logs"
	@echo "  logs-nginx    Follow nginx logs"
	@echo "  shell-db      Open MariaDB shell"
	@echo "  shell-backend Open backend shell"
	@echo "  shell-nginx   Open nginx shell"
	@echo "  certs         Generate self-signed SSL certs"
	@echo "  secrets       Generate secrets folder"
	@echo ""