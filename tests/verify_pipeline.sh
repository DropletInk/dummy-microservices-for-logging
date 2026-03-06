#!/bin/bash

echo "Checking collector logs..."

docker logs central-collector > collector_output.log

grep TEST_LOG_A collector_output.log
grep TEST_LOG_B collector_output.log
grep TEST_LOG_C collector_output.log

if [ $? -eq 0 ]; then
  echo "Pipeline test successful"
else
  echo "Pipeline test failed"
  exit 1
fi

#for test