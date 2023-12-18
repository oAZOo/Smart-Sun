import datetime
import random
import time

import requests

def add_reading_test():
    consumptions = list(range(0, 15, 1))
    light_intensities = list(range(0, 100, 1))
    timestamp = str(datetime.datetime.utcnow().timestamp())
    system_id = '657ce5c881e4021fb27811c0'
    current_consumption = random.choice(consumptions)
    light_intensity = random.choice(light_intensities)

    data = {
        'timestamp': timestamp,
        'system_id': system_id,
        'current_consumption': current_consumption,
        'light_intensity': light_intensity
    }
    response = requests.post(url='http://127.0.0.1:8000/micro_cont/add_reading', json=data)
    print(response.json())



if __name__ == "__main__":
    for i in range(15):
        time.sleep(1)
        add_reading_test()


