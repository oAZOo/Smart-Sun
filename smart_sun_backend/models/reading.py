from pydantic import BaseModel


class Reading(BaseModel):
    timestamp: str
    system_id: str
    current_consumption: float
    light_intensity: float

    def possible_consumption(self):
        """
        implement logic here to return the possible consumption if the value has changed by more than 5%
        """
        raise NotImplemented

