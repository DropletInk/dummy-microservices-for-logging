#!/bin/bash

LOG_FILE="local-logging/logs/local-fluent-bit"
TIMEOUT=120
INTERVAL=5
ELAPSED=0

PATTERN="TESTING FOR LOG MSG FROM SERVICES"

echo "Verifying logs in local Fluent Bit file: $LOG_FILE"

# Check if file exists
if [ ! -f "$LOG_FILE" ]; then
  echo "ERROR: Log file $LOG_FILE does not exist"
  exit 1
fi

# Show file info for debugging
echo "Log file details:"
ls -l "$LOG_FILE"

echo "Checking for log pattern..."

while [ $ELAPSED -lt $TIMEOUT ]; do

  if grep "$PATTERN" "$LOG_FILE" >/dev/null 2>&1; then
    echo "Log found in local Fluent Bit file "
    exit 0
  fi

  sleep $INTERVAL
  ELAPSED=$((ELAPSED + INTERVAL))
  echo "Waiting... ${ELAPSED}s"
done

echo "ERROR: Log not found in $LOG_FILE after ${TIMEOUT}s "
exit 1