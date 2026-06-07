# routes/flight.py
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select

from ..models.flight import Flight, FlightRead, FlightCreate
from ..services.flight_service import get_flights, create_flight

router = APIRouter()

@router.get("/", response_model=list[FlightRead])
async def list_flights(db: AsyncSession = Depends(get_db)):
    flights = await get_flights(db)
    return [FlightRead.from_orm(f) for f in flights]

@router.post("/", response_model=FlightRead)
async def add_flight(flight_in: FlightCreate, db: AsyncSession = Depends(get_db)):
    flight = await create_flight(db, flight_in)
    return FlightRead.from_orm(flight)

async def get_db():
    pass
