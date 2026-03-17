#!/bin/bash

LOG_DIR="local-logging/logs"
TIMEOUT=120
INTERVAL=2
FAILED=0

echo "Checking logs collected by local logging agent..."

# Auto-discover all services except fluent-bit
SERVICES=$(docker compose config --services 2>/dev/null | grep -v fluent-bit | grep -v fluent-bit-central)

if [ -z "$SERVICES" ]; then
  echo "ERROR: Could not discover services from docker-compose"
  exit 1
fi

wait_for_log() {
  local pattern="$1"
  local service="$2"
  local elapsed=0

  echo "Waiting for $service logs..."

  while [ "$elapsed" -lt "$TIMEOUT" ]; do
    if grep -r "$pattern" "$LOG_DIR" >/dev/null 2>&1; then
      echo "$service log found "
      return 0
    fi

    sleep $INTERVAL
    elapsed=$((elapsed + INTERVAL))
  done

  echo "$service log missing after ${TIMEOUT}s "
  return 1
}

echo "Listing log files..."
ls -R "$LOG_DIR" 2>/dev/null || echo "Log dir empty or missing"

for SERVICE in $SERVICES; do
  PATTERN="TESTING FOR LOG MSG FROM SERVICES"
  wait_for_log "$PATTERN" "$SERVICE" || FAILED=1
done

if [ "$FAILED" -eq 1 ]; then
  echo "logs are missing — pipeline test failed"
  exit 1
fi

echo "All logs verified — local logging pipeline test passed"