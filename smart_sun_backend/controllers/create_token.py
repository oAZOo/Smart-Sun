from typing import Optional
from datetime import timedelta, datetime

from fastapi import HTTPException, Depends, status
from fastapi.security import OAuth2PasswordBearer
from jose import jwt, JWTError
from dotenv import dotenv_values

config = dotenv_values(".env")
SECRET = config['SECRET']

def create_access_token(data: dict, expires_delta: Optional[timedelta]):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(days=1)
    to_encode.update({'exp': expire})
    encoded_jwt = jwt.encode(to_encode, SECRET, algorithm='HS256')
    return encoded_jwt


def get_current_user(token: str = Depends(OAuth2PasswordBearer(tokenUrl="token"))):
    credentials_exception = HTTPException(status_code=status.HTTP_401_UNAUTHORIZED,
                                          detail="Could Not Validate credentials",
                                          headers={'WWW-Authenticate': "Bearer"})

    try:
        payload = jwt.decode(token, SECRET, algorithms=['HS256'])
        username: str = payload.get("sub")
        print(username)
        if username is None:
            raise credentials_exception

    except JWTError:
        raise credentials_exception

    return username

