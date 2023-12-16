from bson import ObjectId
from fastapi import APIRouter, Query
from models.switch import Switch
from models.system import System

from database import systems_collection, switches_collection, users_collection

admin_routes = APIRouter()


@admin_routes.post('/create_system')
async def create_new_system(system_data: System, switches: list[Switch]):
    new_system = {
        'system_name': system_data.system_name,
        'address': system_data.address,
        'pv_max_capacity': system_data.pv_max_capacity,
        'is_used': False
    }
    system_result = systems_collection.insert_one(new_system)
    switches = [dict(switch) for switch in switches]
    for switch in switches:
        switch['system_id'] = str(system_result.inserted_id)
    switches_result = switches_collection.insert_many(documents=switches)
    response = {"system_id": str(system_result.inserted_id),
                "switches_ids": str(switches_result.inserted_ids)}
    return response


@admin_routes.post('/systems')
async def get_systems(
        system_id: str = Query(None, description='System Id'),
        pv_max_capacity: int = Query(None, description='Sum of power rating of the PVs'),
        system_name: str = Query(None, description='Name of the system'),
        is_used: bool = Query(None, description='Bool to check the used systems by a user or not')
):
    params = {}
    if system_id:
        params.update({'_id': ObjectId(system_id)})
    if pv_max_capacity:
        params.update({'pv_max_capacity': pv_max_capacity})
    if system_name:
        params.update({'system_name': system_name})
    if is_used:
        params.update({'is_used': True})

    systems = systems_collection.find(params)
    systems_list = []
    for system in systems:
        system['_id'] = str(system['_id'])
        systems_list.append(system)
    return {'systems': systems_list}


@admin_routes.post('/users')
async def get_users(
        username: str = Query(None, description='Username'),
        email: str = Query(None, description='Email'),
        system_id: str = Query(None, description='System ID'),
):
    params = {}
    if username:
        params.update({'username': username})
    if email:
        params.update({'email': email})
    if system_id:
        params.update({'system_id': system_id})

    users = users_collection.find(params)
    users_list = []
    for user in users:
        user['_id'] = str(user['_id'])
        users_list.append(user)
    return {'users': users_list}
