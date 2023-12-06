from pydantic import BaseModel


class Admin(BaseModel):
    username: str
    email: str
    password: str