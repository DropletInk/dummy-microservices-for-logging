#!/bin/bash

LOG_DIR="local-logging/logs"
TIMEOUT=60
INTERVAL=5
ELAPSED=0

echo "Waiting for Fluent Bit to create log files..."

SERVICES=$(docker compose config --services | grep -v -E "fluent-bit|loki|grafana")
EXPECTED=$(echo "$SERVICES" | wc -l | tr -d ' ')

while [ $ELAPSED -lt $TIMEOUT ]; do
  FOUND=$(ls "$LOG_DIR" 2>/dev/null | wc -l | tr -d ' ')

  if [ "$FOUND" -ge "$EXPECTED" ]; then
    echo "All $EXPECTED log files detected:"
    ls -l "$LOG_DIR"
    exit 0
  fi

  sleep $INTERVAL
  ELAPSED=$((ELAPSED + INTERVAL))
  echo "Still waiting... found $FOUND/$EXPECTED files (${ELAPSED}s)"
done

echo "ERROR: Only $FOUND/$EXPECTED log files created after ${TIMEOUT}s"
exit 1