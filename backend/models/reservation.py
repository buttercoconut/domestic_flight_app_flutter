"""Reservation model and schemas.

A reservation links a user to a flight and stores the number of seats and a status.
"""

from datetime import datetime

from sqlalchemy import Column, Integer, ForeignKey, DateTime, Enum
from sqlalchemy.orm import relationship

from . import Base

class ReservationStatus(str, Enum):
    PENDING = "pending"
    CONFIRMED = "confirmed"
    CANCELLED = "cancelled"

class Reservation(Base):
    __tablename__ = "reservations"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    flight_id = Column(Integer, ForeignKey("flights.id"), nullable=False)
    seats = Column(Integer, nullable=False, default=1)
    status = Column(Enum(ReservationStatus), default=ReservationStatus.PENDING, nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow)

    user = relationship("User", back_populates="reservations")
    flight = relationship("Flight")

# Pydantic schemas
from pydantic import BaseModel

class ReservationBase(BaseModel):
    flight_id: int
    seats: int

    class Config:
        orm_mode = True

class ReservationCreate(ReservationBase):
    pass

class ReservationRead(ReservationBase):
    id: int
    user_id: int
    status: ReservationStatus
    created_at: datetime

__all__ = ["Reservation", "ReservationStatus", "ReservationBase", "ReservationCreate", "ReservationRead"]
