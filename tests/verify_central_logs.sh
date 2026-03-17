#!/bin/bash

TIMEOUT=120
INTERVAL=5
ELAPSED=0

PATTERN="TESTING FOR LOG MSG FROM SERVICES"

echo "Verifying logs reached central collector..."

while [ $ELAPSED -lt $TIMEOUT ]; do

  LOGS=$(docker logs central-fluent-bit 2>&1)

  if echo "$LOGS" | grep "$PATTERN" >/dev/null; then
    echo "Logs successfully reached central collector"
    exit 0
  fi

  sleep $INTERVAL
  ELAPSED=$((ELAPSED + INTERVAL))
  echo "Waiting... ${ELAPSED}s"
done

echo "ERROR: Logs did NOT reach central collector"
exit 1