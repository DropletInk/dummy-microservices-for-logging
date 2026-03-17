#!/bin/bash

TIMEOUT=30
INTERVAL=5
ELAPSED=0

echo "Checking central collector..."

while [ $ELAPSED -lt $TIMEOUT ]; do

  if docker logs fluent-bit-central 2>&1 | grep "TESTING FOR LOG MSG FROM SERVICES"; then
    echo "Central collector received logs"
    exit 0
  fi

  sleep $INTERVAL
  ELAPSED=$((ELAPSED + INTERVAL))
  echo "Waiting... ${ELAPSED}s"
done

echo "ERROR: central collector did not receive logs"
exit 1