from pydantic import BaseModel, Field
from bson import ObjectId
from typing import Optional


class System(BaseModel):
    _id: Optional[str]
    system_name: str
    address: str
    pv_max_capacity: int
    is_used: bool = False
