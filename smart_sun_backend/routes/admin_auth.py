from datetime import timedelta

from bson import ObjectId
from fastapi import APIRouter, HTTPException
from passlib.context import CryptContext

from controllers.auth_handler import create_access_token
from models.admin import AdminLogin, Admin
from models.token import Token

from database import admin_collection

from dotenv import load_dotenv
import os

load_dotenv("../.env")
secret_key = str(os.getenv('SECRET'))

admin_auth_routes = APIRouter()


# @admin_auth_routes.post('/create_admin')
# async def register_admin(admin_data: Admin):
#     pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
#     hashed_password = pwd_context.hash(admin_data.password)
#     admin = {
#         'username': admin_data.username,
#         'email': admin_data.email,
#         'password': hashed_password
#     }
#
#     result = admin_collection.insert_one(admin)
#     return {"id": str(result.inserted_id)}


@admin_auth_routes.post('/login', response_model=Token)
async def login_admin(admin: AdminLogin):
    pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
    stored_user = admin_collection.find_one({'email': admin.email})
    if stored_user and pwd_context.verify(admin.password, stored_user['password']):
        data = {
            "email": stored_user['email'],
            "username": stored_user['username'],
            "is_admin": stored_user['is_admin']
        }
        access_token = create_access_token(data=data, secret=secret_key)
        return {"access_token": access_token}
    raise HTTPException(status_code=401, detail="Wrong Credentials")
