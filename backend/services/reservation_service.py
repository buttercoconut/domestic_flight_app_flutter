"""Reservation service logic."""

from sqlalchemy.orm import Session
from .. import models
from ..schemas import ReservationCreate

async def create_reservation(db: Session, reservation_in: ReservationCreate):
    db_reservation = models.Reservation(**reservation_in.dict())
    db.add(db_reservation)
    db.commit()
    db.refresh(db_reservation)
    return db_reservation

async def get_reservation(db: Session, reservation_id: int):
    return db.query(models.Reservation).filter(models.Reservation.id == reservation_id).first()
