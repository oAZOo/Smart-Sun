from pydantic import BaseModel


class User(BaseModel):
    username: str
    email: str
    phone_number: str
    system_id: str
    password: str

class UserLogin(BaseModel):
    email: str
    password: str


