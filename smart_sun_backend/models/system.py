from pydantic import BaseModel


class System(BaseModel):
    system_name: str
    address: str
    pv_max_capacity: int
    is_used: bool = False
