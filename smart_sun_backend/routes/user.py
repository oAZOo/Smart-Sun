from multiprocessing import AuthenticationError

from fastapi import APIRouter, Header
import pymongo
from bson import ObjectId

from controllers.create_token import get_current_user

from dotenv import load_dotenv
import os

from models.user import User
from database import systems_collection, switches_collection, readings_collection

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


@user_routes.get("/get_system")
async def get_system(auth_token: str = Header(..., convert_underscores=False, alias="Authorization")):
    try:
        user_info: User = get_current_user(token=auth_token.split(' ')[1], secret=secret_key)
    except Exception as e:
        raise e
    switches = switches_collection.find({'system_id': user_info.system_id})
    switches_list = []
    for switch in switches:
        switch['_id'] = str(switch['_id'])
        switches_list.append(switch)
    return switches_list


@user_routes.get("/latest_reading")
async def get_latest_reading(auth_token: str = Header(..., convert_underscores=False, alias="Authorization")):
    try:
        user_info: User = get_current_user(token=auth_token.split(' ')[1], secret=secret_key)
    except Exception as e:
        raise e
    system_id = user_info.system_id
    latest_reading = readings_collection.find_one({"system_id": system_id}, sort=[("timestamp", pymongo.DESCENDING)])
    return latest_reading




