#!/bin/bash

echo "Injecting logs..."

# Write via the container's own shell to ensure it goes through the logging driver
docker exec service-a-test sh -c 'echo TEST_LOG_A >&2'
docker exec service-b-test sh -c 'echo TEST_LOG_B >&2'
docker exec service-c-test sh -c 'echo TEST_LOG_C >&2'

# Give fluentd driver time to forward
sleep 2
echo "Logs injected"