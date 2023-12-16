import os

from typing import Optional
from datetime import timedelta, datetime

from fastapi import HTTPException, status, Depends, Header
from jose import jwt, JWTError

from dotenv import load_dotenv

from models.user import User

load_dotenv("../.env")
SECRET = str(os.getenv('SECRET'))

credentials_exception = HTTPException(status_code=status.HTTP_401_UNAUTHORIZED,
                                      detail="Could Not Validate credentials"
                                      )


def create_access_token(
        data: dict,
        secret: str,
):
    to_encode = data.copy()
    expire = datetime.utcnow() + timedelta(days=1)
    to_encode.update({'exp': expire})
    encoded_jwt = jwt.encode(to_encode, secret, algorithm='HS256')
    return encoded_jwt


def get_current_user(token: str = Header(...)) -> User:
    try:
        payload = jwt.decode(token, SECRET, algorithms=['HS256'])
        if payload is None:
            raise credentials_exception
        user = User(
            email=payload['email'],
            system_id=payload['system_id'],
            username=payload['username'],
            phone_number=payload['phone_number']
        )
    except JWTError:
        raise credentials_exception
    return user


def verify_user(token: str = Header(...)) -> bool:
    try:
        payload = jwt.decode(token, SECRET, algorithms=['HS256'])
        if payload is None:
            raise credentials_exception
        if payload['is_admin']:
            raise credentials_exception
    except JWTError:
        raise credentials_exception
    return True


def verify_admin(token: str = Header(...)) -> bool:
    try:
        payload = jwt.decode(token, SECRET, algorithms=['HS256'])
        if not payload['is_admin']:
            raise credentials_exception
    except JWTError:
        raise credentials_exception
    return True
