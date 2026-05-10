"""Reservation domain model."""

from sqlalchemy import Column, Integer, String, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from . import Base

class Reservation(Base):
    __tablename__ = "reservations"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    flight_id = Column(Integer, ForeignKey("flights.id"), nullable=False)
    seat_number = Column(String, nullable=False)
    status = Column(String, default="booked")
    created_at = Column(DateTime, server_default="now()")

    user = relationship("User", back_populates="reservations")
    flight = relationship("Flight", back_populates="reservations")
