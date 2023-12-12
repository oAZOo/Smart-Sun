import json
import time

import requests


def create_user():
    user_data = {
        'username': 'thinkers',
        'password': 'giogio',
        'phone_number': '03255691',
        'system_id': '123',
        'email': 'thinkers@gmail.com'
    }
    response = requests.post(url="http://127.0.0.1:8000/auth/register", json=user_data)
    print(response)
    print(response.json())


def login():
    user_data = {
        'email': 'thinkers@gmail.com',
        'password': 'giogio'
    }
    response = requests.post(url="http://127.0.0.1:8000/auth/login", json=user_data)
    print(response)
    user_auth = response.json()
    print(user_auth)
    return user_auth


def get_profile(token):
    url = "http://localhost:8000/user/profile"
    headers = {"Authorization": f"Bearer {token}"}  # Replace YOUR_TOKEN with an actual token
    response = requests.get(url, headers=headers)
    print("Response Status Code:", response.status_code)
    print("Response Content:", response.json())

def get_system(token):
    url = "http://localhost:8000/user/get_system"
    headers = {"Authorization": f"Bearer {token}"}  # Replace YOUR_TOKEN with an actual token
    response = requests.get(url, headers=headers)
    print("Response Status Code:", response.status_code)
    print("Response Content:", response.json())


if __name__ == "__main__":
    # create_user()
    # token = login()['access_token']
    # print(token)
    # time.sleep(1)
    TOKEN = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imdlb3JnaW9AdGhpbmtlcnMuY29tIiwic3lzdGVtX2lkIjoiNjU3NWIyYWQ1ZDU2OTY2M2I4N2RkOTFkIiwidXNlcm5hbWUiOiJnZW9yZ2lvIiwicGhvbmVfbnVtYmVyIjoiNzYxNTQ2NTUiLCJleHAiOjE3MDIyOTg4MDZ9.iFJ5MiOex17g5JrRKaQJMXoRF9E_GcmvNY7PnbWdLuY'
    # get_system(token=TOKEN)
    # get_profile(token=TOKEN)
