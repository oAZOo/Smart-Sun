from multiprocessing import AuthenticationError

from fastapi import APIRouter, Header
from pydantic import BaseModel, Field
from bson import ObjectId

from controllers.create_token import get_current_user

from dotenv import load_dotenv
import os

from models.user import User
from database import systems_collection

user_routes = APIRouter()
load_dotenv("../.env")
secret_key = str(os.getenv('SECRET'))



@user_routes.get('/profile')
async def get_user_profile(auth_token: str = Header(..., convert_underscores=False, alias="Authorization")):
    try:
        user_info: User = get_current_user(token=auth_token.split(' ')[1], secret=secret_key)
    except Exception as e:
        raise e
    system_id = user_info['system_id']
    try:
        system_data = systems_collection.find_one({'_id': ObjectId(system_id)})
        del system_data['_id']
    except Exception as e:
        print(e)
        raise FileNotFoundError
    data = {**system_data, **user_info}
    return data

    # return user_system_data










