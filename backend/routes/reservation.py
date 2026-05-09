from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from ..database import get_session
from ..models.reservation import Reservation
from ..schemas.reservation import ReservationCreate, ReservationOut
from ..services.reservation_service import create_reservation, list_reservations

router = APIRouter()

@router.post("/", response_model=ReservationOut, status_code=status.HTTP_201_CREATED)
async def book_reservation(res_in: ReservationCreate, db: AsyncSession = Depends(get_session)):
    return await create_reservation(db, res_in)

@router.get("/", response_model=list[ReservationOut])
async def get_reservations(db: AsyncSession = Depends(get_session)):
    return await list_reservations(db)
