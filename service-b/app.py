import json
import time
import random
import logging

logging.basicConfig(level=logging.INFO)

SERVICE_NAME = "service-b"

def log(level: str, message: str):
    record = {
        "service": SERVICE_NAME,
        "level": level,
        "message": message
    }
    print(json.dumps(record), flush=True)

if __name__ == "__main__":
    while True:
        # Simulate different log levels
        if random.choice([True, False]):
            log("DEBUG", "Random diagnostic message")
        else:
            log("WARN", "Potential issue detected")

        time.sleep(5)
