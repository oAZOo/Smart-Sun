import os

from typing import Optional
from datetime import timedelta, datetime

from fastapi import HTTPException, status
from jose import jwt, JWTError

from models.admin import Admin
from models.user import User

from dotenv import load_dotenv

load_dotenv("../.env")
SECRET = str(os.getenv('SECRET'))


def create_access_token(
        data: dict,
        secret: str,
        expires_delta: Optional[timedelta]
):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(days=1)
    to_encode.update({'exp': expire})
    encoded_jwt = jwt.encode(to_encode, secret, algorithm='HS256')
    return encoded_jwt


def get_current_user(token: str, secret: str):
    credentials_exception = HTTPException(status_code=status.HTTP_401_UNAUTHORIZED,
                                          detail="Could Not Validate credentials",
                                          headers={'WWW-Authenticate': "Bearer"})
    try:
        payload = jwt.decode(token, secret, algorithms=['HS256'])

        if payload is None:
            raise credentials_exception

    except JWTError:
        raise credentials_exception

    return payload


def verify_admin(token: str) -> bool:
    credentials_exception = HTTPException(status_code=status.HTTP_401_UNAUTHORIZED,
                                          detail="Could Not Validate credentials",
                                          headers={'WWW-Authenticate': "Bearer"})
    try:
        payload = jwt.decode(token, SECRET, algorithms=['HS256'])
        if payload is None:
            raise credentials_exception

    except JWTError:
        raise credentials_exception
    return True


