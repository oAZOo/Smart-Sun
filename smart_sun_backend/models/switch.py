from pydantic import BaseModel


class Switch(BaseModel):
    system_id: str
    switch_name: str
    state: bool = False
