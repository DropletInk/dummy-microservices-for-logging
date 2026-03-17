#!/bin/bash

TIMEOUT=120
INTERVAL=5
ELAPSED=0

PATTERN="TESTING FOR LOG MSG FROM SERVICES"

echo "Verifying logs at central collector (fluent-bit-central)..."

while [ $ELAPSED -lt $TIMEOUT ]; do

  if docker logs fluent-bit-central 2>&1 | grep "$PATTERN" >/dev/null; then
    echo "Log successfully reached central collector "
    exit 0
  fi

  sleep $INTERVAL
  ELAPSED=$((ELAPSED + INTERVAL))
  echo "Waiting... ${ELAPSED}s"
done

echo "ERROR: Log did NOT reach central collector "
exit 1