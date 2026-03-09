#!/bin/bash

LOG_DIR="local-logging/logs"

echo "Checking logs collected by local logging agent..."

# Wait until log files appear
echo "Waiting for log files..."

for i in {1..20}; do
  if [ -d "$LOG_DIR" ] && [ "$(ls -A $LOG_DIR)" ]; then
    break
  fi
  sleep 2
done

echo "Log directory contents:"
ls -R "$LOG_DIR"

# Check Service A
if grep -r "TEST_LOG_A" "$LOG_DIR"; then
  echo "Service A log found"
else
  echo "Service A log missing"
  exit 1
fi

# Check Service B
if grep -r "TEST_LOG_B" "$LOG_DIR"; then
  echo "Service B log found"
else
  echo "Service B log missing"
  exit 1
fi

# Check Service C
if grep -r "TEST_LOG_C" "$LOG_DIR"; then
  echo "Service C log found"
else
  echo "Service C log missing"
  exit 1
fi

echo "Local logging pipeline test passed"