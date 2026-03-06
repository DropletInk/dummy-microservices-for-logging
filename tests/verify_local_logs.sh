#!/bin/bash

LOG_DIR="local-logging/fluent-bit/logs"

echo "Checking logs collected by local logging agent..."

sleep 5

if grep -r "TEST_LOG_A" $LOG_DIR; then
    echo "Service A log found"
else
    echo "Service A log missing"
    exit 1
fi

if grep -r "TEST_LOG_B" $LOG_DIR; then
    echo "Service B log found"
else
    echo "Service B log missing"
    exit 1
fi

if grep -r "TEST_LOG_C" $LOG_DIR; then
    echo "Service C log found"
else
    echo "Service C log missing"
    exit 1
fi

echo "Local logging pipeline test passed"