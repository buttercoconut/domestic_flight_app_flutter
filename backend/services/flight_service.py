"""Flight service logic."""

from sqlalchemy.orm import Session
from .. import models

async def search_flights(db: Session, origin: str, destination: str, date: str):
    return db.query(models.Flight).filter(
        models.Flight.departure_airport == origin,
        models.Flight.arrival_airport == destination,
        models.Flight.departure_time.like(f"{date}%")
    ).all()
