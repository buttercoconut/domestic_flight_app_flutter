# models/airport.py
from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import declarative_base

Base = declarative_base()

class Airport(Base):
    __tablename__ = "airports"

    id = Column(Integer, primary_key=True, index=True)
    code = Column(String(3), unique=True, index=True, nullable=False)
    name = Column(String, nullable=False)
    city = Column(String, nullable=False)
    country = Column(String, nullable=False)

# Pydantic schemas
from pydantic import BaseModel

class AirportRead(BaseModel):
    id: int
    code: str
    name: str
    city: str
    country: str

    class Config:
        orm_mode = True
