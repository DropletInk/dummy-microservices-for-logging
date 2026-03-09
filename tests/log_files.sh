#!/bin/bash

LOG_DIR="local-logging/logs"
TIMEOUT=120
INTERVAL=5
ELAPSED=0

echo "Waiting for Fluent Bit to create log files..."

while [ $ELAPSED -lt $TIMEOUT ]; do
    if [ -d "$LOG_DIR" ] && [ "$(ls -A "$LOG_DIR" 2>/dev/null)" ]; then
        echo "Log files detected:"
        ls -l "$LOG_DIR"
        exit 0
    fi

    sleep $INTERVAL
    ELAPSED=$((ELAPSED + INTERVAL))
    echo "Still waiting... (${ELAPSED}s)"
done

echo "ERROR: No log files created after ${TIMEOUT}s"
exit 1