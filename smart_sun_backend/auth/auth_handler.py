import time
from typing import Dict

import jwt
import os

from dotenv import load_dotenv

load_dotenv("../.env")
SECRET = str(os.getenv('SECRET'))
ALGO = str(os.getenv('ALGO'))


def token_response(token: str):
    return {
        "access_token": token
    }


# function used for signing the JWT string
def signJWT(data: dict) -> Dict[str, str]:
    payload = {**data, "expires": time.time() + 600}
    token = jwt.encode(payload, SECRET, algorithm='HS256')
    return token


def decodeJWT(token: str) -> dict:
    try:
        decoded_token = jwt.decode(token, SECRET, algorithms=['HS256'])
        return decoded_token if decoded_token["expires"] >= time.time() else None
    except:
        return {}
