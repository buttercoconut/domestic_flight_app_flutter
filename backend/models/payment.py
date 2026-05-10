"""Payment model and schemas.

A very small stub – in a real system you would integrate with a gateway.
"""

from datetime import datetime

from sqlalchemy import Column, Integer, String, Numeric, DateTime, ForeignKey
from sqlalchemy.orm import relationship

from . import Base

class Payment(Base):
    __tablename__ = "payments"

    id = Column(Integer, primary_key=True, index=True)
    reservation_id = Column(Integer, ForeignKey("reservations.id"), nullable=False)
    amount = Column(Numeric(10, 2), nullable=False)
    method = Column(String(50), nullable=False)
    status = Column(String(20), default="pending", nullable=False)
    paid_at = Column(DateTime, default=datetime.utcnow)

    reservation = relationship("Reservation")

# Pydantic schemas
from pydantic import BaseModel

class PaymentBase(BaseModel):
    reservation_id: int
    amount: float
    method: str

    class Config:
        orm_mode = True

class PaymentCreate(PaymentBase):
    pass

class PaymentRead(PaymentBase):
    id: int
    status: str
    paid_at: datetime

__all__ = ["Payment", "PaymentBase", "PaymentCreate", "PaymentRead"]
