import json
import time
import logging

logging.basicConfig(level=logging.INFO)

SERVICE_NAME = "service-c"

def log(level: str, message: str):
    record = {
        "service": SERVICE_NAME,
        "level": level,
        "message": message
    }
    print(json.dumps(record), flush=True)

if __name__ == "__main__":
    counter = 0

    while True:
        counter += 1

        if counter % 3 == 0:
            log("ERROR", "Simulated failure while processing request")
        else:
            log("INFO", "Service is processing requests normally")

        time.sleep(6)
