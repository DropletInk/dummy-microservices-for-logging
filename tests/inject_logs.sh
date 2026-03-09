#!/bin/bash

echo "Injecting logs..."

docker exec service-a-test sh -c 'echo TEST_LOG_A > /proc/1/fd/1'
docker exec service-b-test sh -c 'echo TEST_LOG_B > /proc/1/fd/1'
docker exec service-c-test sh -c 'echo TEST_LOG_C > /proc/1/fd/1'

echo "Logs injected"