from datetime import timedelta

from bson import ObjectId
from fastapi import APIRouter, HTTPException
from passlib.context import CryptContext

from auth.auth_handler import signJWT
from controllers.auth_handler import create_access_token
from models.user import UserLogin, User
from models.token import Token
from database import users_collection, systems_collection

from dotenv import load_dotenv
import os

load_dotenv("../.env")
secret_key = str(os.getenv('SECRET'))

user_auth_routes = APIRouter()


@user_auth_routes.post('/login', response_model=Token)
async def login_user(user: UserLogin):
    pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
    stored_user = users_collection.find_one({'email': user.email})
    if stored_user and pwd_context.verify(user.password, stored_user['password']):
        data = {
            "email": stored_user['email'],
            "system_id": stored_user['system_id'],
            "username": stored_user['username'],
            "phone_number": stored_user['phone_number']
        }
        access_token = signJWT(data=data)
        return {"access_token": access_token}
    raise HTTPException(status_code=401, detail="Wrong Credentials")


@user_auth_routes.post('/register')
def register(user: User):
    pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
    hashed_password = pwd_context.hash(user.password)
    user_system = systems_collection.find_one({"_id": ObjectId(user.system_id)})
    if not user_system:
        raise HTTPException(status_code=400, detail='System ID Not Found')
    else:
        if user_system['is_used'] == True:
            raise HTTPException(status_code=400, detail='System already used by an other user')
        if users_collection.find_one({'username': user.username}):
            raise HTTPException(status_code=400, detail="Username Already Exists")
        if users_collection.find_one({'phone_number': user.phone_number}):
            raise HTTPException(status_code=400, detail="phone number Already associated with another account")
        if users_collection.find_one({'email': user.email}):
            raise HTTPException(status_code=400, detail="email Already associated with another account")

    new_user = {
        'username': user.username,
        'email': user.email,
        'password': hashed_password,
        'system_id': user.system_id,
        'phone_number': user.phone_number,
    }
    systems_collection.find_one_and_update({"_id": ObjectId(user.system_id)}, {'$set': {'is_used': True}})
    result = users_collection.insert_one(new_user)
    return {"id": str(result.inserted_id)}
