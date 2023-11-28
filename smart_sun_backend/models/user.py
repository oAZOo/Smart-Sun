from pydantic import BaseModel


class User(BaseModel):
    username: str
    email: str
    phone_number: str
    system_id: str
    password: str

class UserLogin(BaseModel):
    username: str
    password: str


class Token(BaseModel):
    access_token: str
    token_type: str = "bearer"


