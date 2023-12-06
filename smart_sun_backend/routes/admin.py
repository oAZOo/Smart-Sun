from fastapi import APIRouter

from models.switch import Switch
from models.system import System

from database import systems_collection, switches_collection

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
