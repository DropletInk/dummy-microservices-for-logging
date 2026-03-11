#!/bin/bash

echo "Injecting logs..."

SERVICES=$(docker compose config --services 2>/dev/null | grep -v -E "fluent-bit|loki|grafana")

if [ -z "$SERVICES" ]; then
  echo "ERROR: Could not discover services from docker-compose"
  exit 1
fi

for SERVICE in $SERVICES; do
  CONTAINER="${SERVICE}-test"
  LOG_MSG="TESTING FOR LOG MSG FROM SERVICES"
  echo "Injecting '$LOG_MSG' into $CONTAINER..."
  docker exec "$CONTAINER" sh -c "echo $LOG_MSG > /proc/1/fd/1"
done

sleep 2
echo "Logs injected"