from pydantic import BaseModel
from datetime import datetime

class FlightCreate(BaseModel):
    flight_number: str
    departure_airport_id: int
    arrival_airport_id: int
    departure_time: datetime
    arrival_time: datetime
    price: float

class FlightOut(BaseModel):
    id: int
    flight_number: str
    departure_airport_id: int
    arrival_airport_id: int
    departure_time: datetime
    arrival_time: datetime
    price: float

    class Config:
        orm_mode = True
