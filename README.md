# LAU Course Registration System


*This project has been created as part of the COE313 curriculum by Omar Dana, Yasmina Hijazi, and Majd Jebbeh.*


A full-stack university course registration system built for the Lebanese American University (LAU). Students can browse the course catalogue, register for sections, view their schedule, track academic progress through a dashboard, and visualize their major's course map. Administrators can manage courses, sections, students, and enrollments.

---

## Tech Stack

**Backend:** Java 17, Spring Boot 3, Spring Security, JWT, JPA/Hibernate, MariaDB  
**Frontend:** Angular 21, TypeScript, standalone components  
**Infrastructure:** Docker, Docker Compose, Nginx (reverse proxy), MariaDB 11  

---

## Requirements

- Docker Desktop or Docker Engine + Docker Compose
- Make
- OpenSSL (for self-signed SSL cert generation)
- Python 3 + pip (only if re-running the course scraper)

---

## How to Run

### 1. Clone the repository

```bash
git clone https://github.com/ApparentlyVenus/coe313-course-registration-project.git
cd coe313-course-registration-project
```

### 2. Generate secrets and SSL certificates

```bash
make setup
```

This will:
- Generate a self-signed SSL certificate in `nginx/certs/`
- Generate database credentials and JWT secret in `secrets/`

### 3. Add the local domain to your hosts file

```bash
# Linux / macOS
sudo echo "127.0.0.1 registration.lau.local" >> /etc/hosts

# Windows (run as Administrator)
echo 127.0.0.1 registration.lau.local >> C:\Windows\System32\drivers\etc\hosts
```
This is required for the nginx and SSL certificate configuation

### 4. Start the application

```bash
make up
```

This starts all containers (database, backend, frontend, nginx, adminer). The database is automatically seeded with:
- Full LAU course catalogue (1,587 courses across all schools and departments)
- COE major course map
- Spring 2026 semester with sections and schedules
- Demo user accounts

Wait about 30 seconds for all services to initialize.

### 5. Access the application

| Service | URL |
|---|---|
| Application (local) | https://registration.lau.local |
| Application (network) | https://your-local-ip |
| Adminer (DB UI) | https://registration.lau.local/adminer |

> **Note:** Your browser will warn about the self-signed certificate. Click "Advanced" and proceed.
> 
> **Network access:** To access from other devices on the same network, find your local IP with `ip a` (Linux/macOS) or `ipconfig` (Windows), then navigate to `https://<your-ip>`. You may need to regenerate the SSL cert with your IP using `make certs` after updating `nginx/nginx.conf` with your IP in `server_name`, as well as updating the `make certs` command itself in the `Makefile` with your ip address.
---

## Demo Accounts

All accounts use the password: `password123`

| Role | Email | Description |
|---|---|---|
| Admin | admin@lau.edu.lb | Full system access |
| COE Student | coe@lau.edu.lb | Computer Engineering student |
| ELE Student | ele@lau.edu.lb | Electrical Engineering student |
| CSC Student | csc@lau.edu.lb | Computer Science student |
| BUS Student | bus@lau.edu.lb | Business Administration student |

> Other student accounts follow the pattern `{major abbreviation lowercase}@lau.edu.lb`

---

## Features

**Student**
- Dashboard with credit progress ring and current enrollments
- Course catalogue with search and department filtering
- Course map showing academic plan with completion status
- Section enrollment with prerequisite validation, conflict detection, and waitlist
- Schedule view

**Admin**
- System dashboard with stats
- Course management (CRUD)
- Section management with schedules
- Student overview with enrollment history
- Mark enrollments as completed

---

## Stopping the Application

```bash
make down        # stop containers
make clean       # stop and wipe all data (full reset)
```

---

## Useful Commands

```bash
make logs           # follow all logs
make logs-backend   # follow backend logs only
make shell-db       # open MariaDB shell
make re-backend     # rebuild backend only
make re-frontend    # rebuild frontend only
```

---

## Notes

- The course catalogue was scraped from the LAU Academic Catalogue 2025-2026 using Playwright
- The COE course map is based on the official COE curriculum effective Fall 2023
- JWT tokens expire after 24 hours — logging out and back in refreshes the token
- `COE 201` has a section capacity of 1 for waitlist demonstration purposes
