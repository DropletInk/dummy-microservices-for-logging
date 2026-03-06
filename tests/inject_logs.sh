#!/bin/bash

echo "Injecting logs..."

docker exec service-a-test sh -c "echo TEST_LOG_A"
docker exec service-b-test sh -c "echo TEST_LOG_B"
docker exec service-c-test sh -c "echo TEST_LOG_C"

echo "Logs are injected"


sleep 5



#for test