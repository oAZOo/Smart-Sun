from pydantic import BaseModel


class Admin(BaseModel):
    username: str
    email: str
    password: str


class AdminLogin(BaseModel):
    email: str
    password: str