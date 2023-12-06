from datetime import timedelta

from bson import ObjectId
from fastapi import APIRouter, HTTPException
from passlib.context import CryptContext

from controllers.create_token import create_access_token
from models.admin import AdminLogin
from models.token import Token

from database import admin_collection

from dotenv import load_dotenv
import os

load_dotenv("../.env")
secret_key = str(os.getenv('SECRET'))

admin_auth_routes = APIRouter()


@admin_auth_routes.post('/login', response_model=Token)
async def login_admin(admin: AdminLogin):
    pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
    stored_user = admin_collection.find_one({'email': admin.email})
    if stored_user and pwd_context.verify(admin.password, stored_user['password']):
        data = {
            "email": stored_user['email'],
            "username": stored_user['username'],
        }
        access_token = create_access_token(data=data, expires_delta=timedelta(days=1), secret=secret_key)
        return {"access_token": access_token}
    raise HTTPException(status_code=401, detail="Wrong Credentials")
