from fastapi import APIRouter

from models.system import System

from database import systems_collection

admin_routes = APIRouter()


@admin_routes.post('/create_system')
async def create_new_system(system_data: System):
    new_system = {
        'system_name': system_data.system_name,
        'address': system_data.address,
        'pv_max_capacity': system_data.pv_max_capacity,
        'is_used': False
    }
    result = systems_collection.insert_one(new_system)
    return {"id": str(result.inserted_id)}
