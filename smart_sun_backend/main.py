from fastapi import FastAPI, Depends

from auth.auth_bearer import JWTBearer
from controllers.create_token import verify_user, verify_admin
from database import db_client
from routes import user_auth, user, admin, admin_auth

app = FastAPI()

app.include_router(user_auth.user_auth_routes, prefix="/user_auth", tags=["user_auth"])
app.include_router(user.user_routes, prefix='/user', tags=["user"], dependencies=[Depends(verify_user)])
app.include_router(admin.admin_routes, prefix='/admin', tags=['admin'],  dependencies=[Depends(verify_admin)])
app.include_router(admin_auth.admin_auth_routes, prefix='/admin_auth', tags=['admin_auth'])


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
