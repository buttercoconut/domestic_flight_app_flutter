# routes/reservation.py
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession

from ..models.reservation import Reservation, ReservationRead, ReservationCreate
from ..services.reservation_service import create_reservation, get_reservations_by_user

router = APIRouter()

@router.post("/", response_model=ReservationRead)
async def book_reservation(res_in: ReservationCreate, db: AsyncSession = Depends(get_db)):
    reservation = await create_reservation(db, res_in)
    return ReservationRead.from_orm(reservation)

@router.get("/user/{user_id}", response_model=list[ReservationRead])
async def list_user_reservations(user_id: int, db: AsyncSession = Depends(get_db)):
    reservations = await get_reservations_by_user(db, user_id)
    return [ReservationRead.from_orm(r) for r in reservations]

async def get_db():
    pass
