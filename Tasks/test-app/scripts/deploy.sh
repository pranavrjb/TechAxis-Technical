#!//bin/bash

APP_NAME="test-app"
COMPOSE_FILE="compose.yml"

echo "Starting deployment for $APP_NAME..."

echo "Removing old containers..."

docker-compose down --remove-orphans

echo "Building a Docker images"

docker-compose build --no-cache

echo "Starting service"

docker-compose up -d

echo "Checking status"

docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo "Deployment complete! Backend on :5000, Frontend on :80"