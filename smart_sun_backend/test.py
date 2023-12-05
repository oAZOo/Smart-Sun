import requests

from controllers.create_token import get_current_user


def create_user():
    user_data = {
        'username': 'starbucks',
        'password': 'georgio',
        'phone_number': '03255891',
        'system_id': '123',
        'email': 'starbucks@gmail.com'
    }
    response = requests.post(url="http://127.0.0.1:8000/register", json=user_data)
    print(response)
    print(response.json())




def login():
    user_data = {
        'email': 'starbucks@gmail.com',
        'password': 'georgi'
    }
    response = requests.post(url="http://127.0.0.1:8000/login", json=user_data)
    print(response)
    user_auth = response.json()
    print(user_auth)
    # print(get_current_user(token=user_auth['access_token']))




if __name__ =="__main__":
    # create_user()
    login()

