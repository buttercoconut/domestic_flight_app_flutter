"""Flight model and schemas.

A flight is scheduled between two airports at a specific departure and arrival
time.  The price is stored as a decimal.
"""

from datetime import datetime
from decimal import Decimal

from sqlalchemy import Column, Integer, String, DateTime, Numeric, ForeignKey
from sqlalchemy.orm import relationship

from . import Base

class Flight(Base):
    __tablename__ = "flights"

    id = Column(Integer, primary_key=True, index=True)
    flight_number = Column(String(10), unique=True, nullable=False, index=True)
    departure_airport_id = Column(Integer, ForeignKey("airports.id"), nullable=False)
    arrival_airport_id = Column(Integer, ForeignKey("airports.id"), nullable=False)
    departure_time = Column(DateTime, nullable=False)
    arrival_time = Column(DateTime, nullable=False)
    price = Column(Numeric(10, 2), nullable=False)

    departure_airport = relationship("Airport", foreign_keys=[departure_airport_id])
    arrival_airport = relationship("Airport", foreign_keys=[arrival_airport_id])

# Pydantic schemas
from pydantic import BaseModel

class FlightBase(BaseModel):
    flight_number: str
    departure_airport_id: int
    arrival_airport_id: int
    departure_time: datetime
    arrival_time: datetime
    price: Decimal

    class Config:
        orm_mode = True

class FlightCreate(FlightBase):
    pass

class FlightRead(FlightBase):
    id: int

__all__ = ["Flight", "FlightBase", "FlightCreate", "FlightRead"]
