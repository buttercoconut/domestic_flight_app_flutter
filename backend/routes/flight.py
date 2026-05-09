from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from ..database import get_session
from ..models.flight import Flight
from ..schemas.flight import FlightCreate, FlightOut
from ..services.flight_service import create_flight, list_flights

router = APIRouter()

@router.post("/", response_model=FlightOut, status_code=status.HTTP_201_CREATED)
async def add_flight(flight_in: FlightCreate, db: AsyncSession = Depends(get_session)):
    return await create_flight(db, flight_in)

@router.get("/", response_model=list[FlightOut])
async def get_flights(db: AsyncSession = Depends(get_session)):
    return await list_flights(db)
