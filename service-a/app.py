import json
import logging
import time

logging.basicConfig(level=logging.INFO)

SERVICE_NAME = "service-a"

def log(level, message):
    record = {
        "service": SERVICE_NAME,
        "level": level,
        "message": message
    }
    print(json.dumps(record), flush=True)

while True:
    log("INFO", "Service is running normally")
    time.sleep(5)
