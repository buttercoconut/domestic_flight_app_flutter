"""Reservation routes."""

from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from .. import services
from ..dependencies import get_db

router = APIRouter()

@router.post("/")
async def create_reservation(reservation: services.ReservationCreate, db: Session = Depends(get_db)):
    return await services.reservation_service.create_reservation(db, reservation)

@router.get("/{reservation_id}")
async def get_reservation(reservation_id: int, db: Session = Depends(get_db)):
    return await services.reservation_service.get_reservation(db, reservation_id)
