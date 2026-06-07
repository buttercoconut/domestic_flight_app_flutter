# models/flight.py
from sqlalchemy import Column, Integer, String, DateTime, Float, ForeignKey
from sqlalchemy.orm import declarative_base

Base = declarative_base()

class Flight(Base):
    __tablename__ = "flights"

    id = Column(Integer, primary_key=True, index=True)
    flight_number = Column(String, unique=True, index=True, nullable=False)
    departure_airport_id = Column(Integer, ForeignKey("airports.id"))
    arrival_airport_id = Column(Integer, ForeignKey("airports.id"))
    departure_time = Column(DateTime, nullable=False)
    arrival_time = Column(DateTime, nullable=False)
    price = Column(Float, nullable=False)

# Pydantic schemas
from pydantic import BaseModel
from datetime import datetime

class FlightCreate(BaseModel):
    flight_number: str
    departure_airport_id: int
    arrival_airport_id: int
    departure_time: datetime
    arrival_time: datetime
    price: float

class FlightRead(BaseModel):
    id: int
    flight_number: str
    departure_airport_id: int
    arrival_airport_id: int
    departure_time: datetime
    arrival_time: datetime
    price: float

    class Config:
        orm_mode = True
