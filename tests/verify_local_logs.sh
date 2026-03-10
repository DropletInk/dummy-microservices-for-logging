SERVICES=$(docker compose config --services | grep -v fluent-bit)

wait_for_log() {
  local pattern=$1
  local service=$2
  local elapsed=0

  echo "Waiting for $service logs..."

  while [ $elapsed -lt $TIMEOUT ]; do
    if grep -r "$pattern" "$LOG_DIR" >/dev/null 2>&1; then
      echo "$service log found"
      return 0
    fi

    sleep $INTERVAL
    elapsed=$((elapsed + INTERVAL))
  done

  echo "$service log missing after ${TIMEOUT}s"
  return 1
}

echo "Listing log files..."
ls -R "$LOG_DIR" || true

# Dynamically check each service
for SERVICE in $SERVICES; do
  PATTERN="TEST_LOG_${SERVICE^^}"
  wait_for_log "$PATTERN" "$SERVICE" || FAILED=1
done

if [ $FAILED -eq 1 ]; then
  echo "Some logs missing — pipeline test FAILED"
  exit 1
fi

echo "All logs verified — local logging pipeline test passed"