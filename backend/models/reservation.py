# models/reservation.py
from sqlalchemy import Column, Integer, ForeignKey, DateTime, String
from sqlalchemy.orm import declarative_base

Base = declarative_base()

class Reservation(Base):
    __tablename__ = "reservations"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"))
    flight_id = Column(Integer, ForeignKey("flights.id"))
    seat_number = Column(String, nullable=False)
    status = Column(String, default="booked")
    created_at = Column(DateTime, nullable=False)

# Pydantic schemas
from pydantic import BaseModel
from datetime import datetime

class ReservationCreate(BaseModel):
    user_id: int
    flight_id: int
    seat_number: str

class ReservationRead(BaseModel):
    id: int
    user_id: int
    flight_id: int
    seat_number: str
    status: str
    created_at: datetime

    class Config:
        orm_mode = True
