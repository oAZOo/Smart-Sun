import fastapi.requests
from fastapi import APIRouter, HTTPException
import pymongo
from bson import ObjectId

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
    return latest_reading


@user_routes.post('/toggle_switch')
async def toggle_switch(
        request: fastapi.Request,
        switch_id: str,
):
    auth_token = request.headers.get('token')
    user_info: User = get_current_user(token=auth_token)
    system_id = user_info.system_id
    switches = switches_collection.find({'_id': ObjectId(switch_id)})
    switch = [s for s in switches]
    switch = switch[0]
    if not switch:
        return {'error': 'switch not found'}
    if switch['system_id'] == system_id:
        if switch['state'] == True:
            new_state = False
        else:
            new_state = True
        update_result = switches_collection.update_one({'_id': ObjectId(switch_id)}, {'$set': {'state': new_state}})
        if update_result.matched_count > 0:
            print(f"Matched {update_result.matched_count} document(s).")
            if update_result.modified_count > 0:
                response = {'success': f"Modified {update_result.modified_count} document(s)."}
            else:
                response = {'error': "No documents were modified."}
        else:
            response = {'error': "No documents matched the query."}
    else:
        response = {'error': 'the switch doesnt belong to you'}
    return response




