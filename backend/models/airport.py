"""Airport model and schemas.

An airport has a 3‑letter IATA code, a name and a city.
"""

from sqlalchemy import Column, Integer, String
from . import Base

class Airport(Base):
    __tablename__ = "airports"

    id = Column(Integer, primary_key=True, index=True)
    code = Column(String(3), unique=True, nullable=False, index=True)
    name = Column(String(100), nullable=False)
    city = Column(String(100), nullable=False)

# Pydantic schemas
from pydantic import BaseModel

class AirportBase(BaseModel):
    code: str
    name: str
    city: str

    class Config:
        orm_mode = True

class AirportCreate(AirportBase):
    pass

class AirportRead(AirportBase):
    id: int

__all__ = ["Airport", "AirportBase", "AirportCreate", "AirportRead"]
