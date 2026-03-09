#!/bin/bash

LOG_DIR="local-logging/logs"

echo "Checking logs collected by local logging agent..."

sleep 5

# Check Service A
if grep -r "TEST_LOG_A" "$LOG_DIR/service-a-test"; then
  echo "Service A log found"
else
  echo "Service A log missing"
  exit 1
fi

# Check Service B
if grep -r "TEST_LOG_B" "$LOG_DIR/service-b-test"; then
  echo "Service B log found"
else
  echo "Service B log missing"
  exit 1
fi

# Check Service C
if grep -r "TEST_LOG_C" "$LOG_DIR/service-c-test"; then
  echo "Service C log found"
else
  echo "Service C log missing"
  exit 1
fi

echo "Local logging pipeline test passed"