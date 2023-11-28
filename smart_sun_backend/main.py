from datetime import timedelta

import fastapi
from fastapi import HTTPException
from dotenv import dotenv_values
from pymongo.mongo_client import MongoClient
from passlib.context import CryptContext

from controllers.create_token import create_access_token
from models.user import User, Token, UserLogin

config = dotenv_values(".env")
app = fastapi.FastAPI()
db_client = MongoClient(config['DB_CONNECTION_STRING'])
db = db_client['smart_sun']

users_collection = db["users"]
systems_collection = db["systems"]


@app.on_event('startup')
def startup_db_client():
    try:
        db_client.admin.command('ping')
        print("Pinged your deployment. You successfully connected to MongoDB!")
    except Exception as e:
        print(e)


@app.on_event('shutdown')
def shutdown_db_client():
    try:
        db_client.close()
        print('DB Client Closed Successfully')
    except Exception as e:
        print(e)

@app.post('/register')
def register(user: User):
    pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
    hashed_password = pwd_context.hash(user.password)
    # if not systems_collection.find_one({"_id": user.system_id}):
    #     raise HTTPException(status_code=400, detail='System ID Not Found')
    # if users_collection.find_one({'username': user.username}):
    #     raise HTTPException(status_code=400, detail="Username Already Exists")
    # if users_collection.find_one({'phone_number': user.phone_number}):
    #     raise HTTPException(status_code=400, detail="phone number Already associated with another account")
    # if users_collection.find_one({'email': user.email}):
    #     raise HTTPException(status_code=400, detail="email Already associated with another account")

    new_user = {
        'username': user.username,
        'email': user.email,
        'password': hashed_password,
        'system_id': user.system_id,
        'phone_number': user.phone_number,
    }
    result = users_collection.insert_one(new_user)
    return {"id": str(result.inserted_id)}





@app.post('/login', response_model=Token)
async def login_user(user: UserLogin):
    pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
    stored_user = users_collection.find_one({'username': user.username})
    if stored_user and pwd_context.verify(user.password, stored_user['password']):
        data = {
            "username": stored_user['username'],
            "system_id": stored_user['system_id'],
        }
        access_token = create_access_token(data=data, expires_delta=timedelta(days=1))
        return {"access_token": access_token}
    raise HTTPException(status_code=401, detail="Wrong Credentials")


