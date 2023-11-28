import requests


def test_create_user():
    user_data = {
        'username': 'hanna Hanna',
        'password': 'kifak',
        'phone_number': '03235991',
        'system_id': 'skdjksjd',
        'email': 'kiasjkdjkasfak@gmail.com'
    }
    response = requests.post(url="http://127.0.0.1:8000/register", json=user_data)
    print(response)
    print(response.json())


test_create_user()