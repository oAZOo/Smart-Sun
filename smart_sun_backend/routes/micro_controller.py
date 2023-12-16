from fastapi import APIRouter
from models.reading import Reading
from database import readings_collection
from database import switches_collection
from bson import ObjectId
from bson.errors import InvalidId

micro_controller_route = APIRouter()



@micro_controller_route.post('/add_reading')
def add_reading(reading: Reading):
    reading_to_add = {**reading.__dict__}
    readings_collection.insert_one(reading_to_add)
    return {'success': True}


@micro_controller_route.get('/get_switch_state')
def get_relay_state(system_id) -> dict:
    response = {}
    try:
        cursor = switches_collection.find({'_id': ObjectId(system_id)})
    except InvalidId:
        return {'error': 'invalid_switch'}

    if cursor:
        for switch in cursor:
            response.update({
                str(switch['_id']): switch['state']
            })
        return response
    return {'error': 'didn\'t find your switches'}


