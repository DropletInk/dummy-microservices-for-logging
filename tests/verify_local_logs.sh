#!/bin/bash

LOG_DIR="local-logging/logs"
TIMEOUT=120
INTERVAL=2
FAILED=0

echo "Checking logs collected by local logging agent..."

SERVICES=$(docker compose config --services 2>/dev/null | grep -v local-fluent-bit | grep -v central-fluent-bit)

if [ -z "$SERVICES" ]; then
  echo "ERROR: Could not discover services from docker-compose"
  exit 1
fi

echo "Listing log files..."
ls -R "$LOG_DIR" 2>/dev/null || echo "Log dir empty or missing"

wait_for_service_log() {
  local service="$1"
  local elapsed=0

  echo "Waiting for logs from $service..."

  while [ "$elapsed" -lt "$TIMEOUT" ]; do

    # check service-specific log presence
    if grep -r "$service" "$LOG_DIR" >/dev/null 2>&1 && \
       grep -r "TESTING FOR LOG MSG FROM SERVICES" "$LOG_DIR" >/dev/null 2>&1; then
      echo "$service logs found "
      return 0
    fi

    sleep $INTERVAL
    elapsed=$((elapsed + INTERVAL))
  done

  echo "$service logs missing after ${TIMEOUT}s "
  return 1
}

for SERVICE in $SERVICES; do
  wait_for_service_log "$SERVICE" || FAILED=1
done

if [ "$FAILED" -eq 1 ]; then
  echo "Logs are missing — local logging pipeline test failed "
  exit 1
fi

echo "All logs verified — local logging pipeline test passed "