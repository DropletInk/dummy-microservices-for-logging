#!/bin/bash

LOG_DIR="local-logging/logs"

echo "Checking logs..."

sleep 10

grep TEST_LOG_A $LOG_DIR/service-a-test || { echo "Service A log missing"; exit 1; }
grep TEST_LOG_B $LOG_DIR/service-b-test || { echo "Service B log missing"; exit 1; }
grep TEST_LOG_C $LOG_DIR/service-c-test || { echo "Service C log missing"; exit 1; }

echo "Local logging pipeline test passed"