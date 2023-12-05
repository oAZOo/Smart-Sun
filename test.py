import requests



def create_user():
    user_data = {
        'username': 'thinkers',
        'password': 'giogio',
        'phone_number': '03255691',
        'system_id': '123',
        'email': 'thinkers@gmail.com'
    }
    response = requests.post(url="http://127.0.0.1:8000/register", json=user_data)
    print(response)
    print(response.json())




def login():
    user_data = {
        'email': 'thinkers@gmail.com',
        'password': 'giogio'
    }
    response = requests.post(url="http://127.0.0.1:8000/login", json=user_data)
    print(response)
    user_auth = response.json()
    print(user_auth)





if __name__ =="__main__":
    # create_user()
    while True:
        login()

