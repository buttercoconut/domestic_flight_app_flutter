"""Payment domain model."""

from sqlalchemy import Column, Integer, String, Float, DateTime
from . import Base

class Payment(Base):
    __tablename__ = "payments"

    id = Column(Integer, primary_key=True, index=True)
    reservation_id = Column(Integer, nullable=False)
    amount = Column(Float, nullable=False)
    payment_method = Column(String, nullable=False)
    status = Column(String, default="pending")
    transaction_id = Column(String, unique=True, nullable=False)
    processed_at = Column(DateTime)
