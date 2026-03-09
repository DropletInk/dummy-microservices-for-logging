#!/bin/bash

LOG_DIR="local-logging/logs"
TIMEOUT=180
INTERVAL=2

echo "Checking logs collected by local logging agent..."

wait_for_log() {
  local pattern=$1
  local service=$2
  local elapsed=0

  echo "Waiting for $service logs..."

  while [ $elapsed -lt $TIMEOUT ]; do
    if grep -r "$pattern" "$LOG_DIR" >/dev/null 2>&1; then
      echo "$service log found"
      return 0
    fi

    sleep $INTERVAL
    elapsed=$((elapsed + INTERVAL))
  done

  echo "$service log missing after ${TIMEOUT}s"
  return 1
}

# Show log directory for debugging
echo "Listing log files..."
ls -R "$LOG_DIR" || true

# Check logs
wait_for_log "TEST_LOG_A" "Service A" || exit 1
wait_for_log "TEST_LOG_B" "Service B" || exit 1
wait_for_log "TEST_LOG_C" "Service C" || exit 1

echo "Local logging pipeline test passed"