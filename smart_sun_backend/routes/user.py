import fastapi.requests
from fastapi import APIRouter, HTTPException
import pymongo
from bson import ObjectId
from bson.errors import InvalidId

from controllers.auth_handler import get_current_user

from dotenv import load_dotenv
import os

from models.user import User
from database import systems_collection, switches_collection, readings_collection

user_routes = APIRouter()
load_dotenv("../.env")
secret_key = str(os.getenv('SECRET'))


@user_routes.get('/profile')
async def get_user_profile(request: fastapi.Request):
    auth_token = request.headers.get('token')
    user_info: User = get_current_user(token=auth_token)
    system_id = user_info.system_id
    system_data = systems_collection.find_one({'_id': ObjectId(str(system_id))})
    system_data['_id'] = str(system_data['_id'])
    if not system_data:
        return HTTPException(status_code=404,
                             detail="System Not Found")
    data = {**system_data, **user_info.__dict__}
    return data


@user_routes.get("/get_system")
async def get_system(request: fastapi.Request):
    auth_token = request.headers.get('token')
    user_info: User = get_current_user(token=auth_token)
    switches = switches_collection.find({'system_id': user_info.system_id})
    switches_list = []
    for switch in switches:
        switch['_id'] = str(switch['_id'])
        switches_list.append(switch)
    if len(switches_list) == 0:
        return HTTPException(status_code=404,
                             detail="System Data Not Found")
    return switches_list


@user_routes.get("/latest_reading")
async def get_latest_reading(request: fastapi.Request):
    auth_token = request.headers.get('token')
    user_info: User = get_current_user(token=auth_token)
    system_id = user_info.system_id
    latest_reading = readings_collection.find_one({"system_id": system_id}, sort=[("timestamp", pymongo.DESCENDING)])
    latest_reading['_id'] = str(latest_reading['_id'])
    return latest_reading


@user_routes.post('/toggle_switch')
async def toggle_switch(
        request: fastapi.Request,
        switch_id: str,
):
    auth_token = request.headers.get('token')
    user_info: User = get_current_user(token=auth_token)
    system_id = user_info.system_id
    try:
        switch = switches_collection.find_one({'_id': ObjectId(switch_id)})
        if not switch:
            return {'error': 'Switch not found'}
    except InvalidId:
        return {'error': 'Invalid switch ID'}

    if switch['system_id'] != system_id:
        return {'error': 'The switch doesn\'t belong to you'}

    new_state = not switch['state']

    update_result = switches_collection.find_one_and_update(
        {'_id': ObjectId(switch_id)},
        {'$set': {'state': new_state}},
        return_document=True  # Return the updated document
    )

    if update_result:
        response = {'success': 'Switch state toggled successfully', 'state': update_result['state']}
    else:
        response = {'error': 'Failed to toggle switch state'}

    return response




