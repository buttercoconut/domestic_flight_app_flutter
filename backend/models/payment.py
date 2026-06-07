# models/payment.py
from sqlalchemy import Column, Integer, String, Float, ForeignKey
from sqlalchemy.orm import declarative_base

Base = declarative_base()

class Payment(Base):
    __tablename__ = "payments"

    id = Column(Integer, primary_key=True, index=True)
    reservation_id = Column(Integer, ForeignKey("reservations.id"))
    amount = Column(Float, nullable=False)
    method = Column(String, nullable=False)
    status = Column(String, default="pending")

# Pydantic schemas
from pydantic import BaseModel

class PaymentCreate(BaseModel):
    reservation_id: int
    amount: float
    method: str

class PaymentRead(BaseModel):
    id: int
    reservation_id: int
    amount: float
    method: str
    status: str

    class Config:
        orm_mode = True
