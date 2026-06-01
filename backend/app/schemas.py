from pydantic import BaseModel, Field
from datetime import datetime
from typing import Optional

class FlightBase(BaseModel):
    flight_number: str = Field(..., example="AA123")
    origin: str = Field(..., example="JFK")
    destination: str = Field(..., example="LAX")
    departure_time: datetime = Field(..., example="2024-10-01T08:00:00Z")
    arrival_time: datetime = Field(..., example="2024-10-01T11:00:00Z")
    status: Optional[str] = Field("scheduled", example="scheduled")
    price: float = Field(..., example=199.99)

class FlightCreate(FlightBase):
    pass

class FlightOut(FlightBase):
    id: int

    class Config:
        orm_mode = True
