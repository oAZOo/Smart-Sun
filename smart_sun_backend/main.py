from fastapi import FastAPI, Depends

from controllers.create_token import get_current_user
from database import db_client
from routes import auth, user, admin

app = FastAPI()

app.include_router(auth.auth_routes, prefix="/auth", tags=["auth"])
app.include_router(user.user_routes, prefix='/user', tags=["user"])
app.include_router(admin.admin_routes, prefix='/admin', tags=['admin'])


@app.on_event('startup')
def startup_db_client():
    try:
        db_client.admin.command('ping')
        print("You successfully connected to MongoDB!")
    except Exception as e:
        print(e)


@app.on_event('shutdown')
def shutdown_db_client():
    try:
        db_client.close()
        print('DB Client Closed Successfully')
    except Exception as e:
        print(e)
