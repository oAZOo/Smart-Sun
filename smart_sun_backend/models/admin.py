from pydantic import BaseModel


class Admin(BaseModel):
    username: str
    email: str
    password: str
    is_admin: bool


class AdminLogin(BaseModel):
    email: str
    password: str