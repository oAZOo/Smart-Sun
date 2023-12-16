from fastapi import APIRouter
from models.reading import Reading
from database import readings_collection

micro_controller_route = APIRouter()


@micro_controller_route.post('/add_reading')
def add_reading(reading: Reading):
    reading_to_add = {**reading.__dict__}
    readings_collection.insert_one(reading_to_add)
    return {'success': True}

