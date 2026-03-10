#!/bin/bash

echo "Injecting logs..."

# Auto discover all services
SERVICES=$(docker config --services | grep -v fluent-bit)

for SERVICE in $SERVICES; do
  CONTAINER="${SERVICE}-test"
  echo "Injecting log into $CONTAINER"
  docker exec "$CONTAINER" sh -c "echo TEST_LOG_${SERVICE^^} > /prod/1/fd/1"
done
# Give fluentd driver time to forward
sleep 2
echo "Logs injected"