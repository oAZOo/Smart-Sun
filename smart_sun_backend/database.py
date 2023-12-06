from dotenv import dotenv_values
from pymongo import MongoClient

config = dotenv_values(".env")
db_client = MongoClient(config['DB_CONNECTION_STRING'])
db = db_client['smart_sun']

users_collection = db["users"]
systems_collection = db["systems"]
notifications_collection = db["notifications"]
readings_collection = db['readings']


