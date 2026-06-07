# services/flight_service.py
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from ..models.flight import Flight, FlightCreate

async def get_flights(db: AsyncSession):
    result = await db.execute(select(Flight))
    return result.scalars().all()

async def create_flight(db: AsyncSession, flight_in: FlightCreate):
    flight = Flight(**flight_in.dict())
    db.add(flight)
    await db.commit()
    await db.refresh(flight)
    return flight
