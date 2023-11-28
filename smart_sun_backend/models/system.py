from pydantic import BaseModel


class System(BaseModel):
    system_name: str
    address: str
    is_used: bool = False
