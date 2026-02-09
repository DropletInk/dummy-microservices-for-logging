# dummy-microservices-for-logging
It contains 3 independent micro-services:

**service-a:** Produces **INFO** level log

**service-b:** Produces **WARN** level log

**service-c:** Produces both **INFO** and **ERROR** level logs

Each service:

Runs inside a Docker container

Emits structured JSON logs to stdout

A single docker-compose.yml to run all services together

## Prerequisites:

Make sure the following are installed on your system:

**Docker (v20+),
Docker Compose (v2+),
Linux system with systemd (for journald)**

verify with commands: 
```bash
docker --version
docker compose version
```
### Important: Docker Configuration (Required):
These services assume Docker is using journald as the logging driver.

## **Step-1**: 
Check current logging driver:  
```bash
docker info | grep "Logging Driver"
```
Expected output: 
**Logging Driver: journald**

If not, configure Docker:  
```bash
sudo nano /etc/docker/daemon.json
```
Add: 

```bash
{
"log-driver": "journald"
}
```
Restart Docker:  
```bash
sudo systemctl restart docker
```
## **Step-2:** 
Run the Microservices 
1. Clone the repository :
```bash
git clone (https://github.com/DropletInk/dummy-microservices-for-logging.git)
```
2. Get inside the folder
```bash
cd microservices-logging
```
3. Build the services :
```bash
docker compose build
```
This builds Docker images for: service-a | service-b | service-c

4. Start all services :
```bash
docker compose up -d
```
5. Verify services are running:
```bash
docker compose ps
```
## **Step-3:**
Viewing Logs (Multiple Ways)
### Option 1: Docker Compose logs
**all services:**
```bash
docker compose logs -f
```
**Single service:**
```bash
docker compose logs -f service-b
```
### Option 2: using Journald
**all services**
```bash
journalctl CONTAINER_NAME=service-a -f
```
**All services together:**
```bash
journalctl CONTAINER_NAME=service-a \
           CONTAINER_NAME=service-b \
           CONTAINER_NAME=service-c \
           -f
```
## Example output:

<img width="806" height="130" alt="image" src="https://github.com/user-attachments/assets/123dfcea-9f70-4214-a884-9c036bc7e148" />





