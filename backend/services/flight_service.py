from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from ..models.flight import Flight
from ..schemas.flight import FlightCreate, FlightOut

async def create_flight(db: AsyncSession, flight_in: FlightCreate) -> FlightOut:
    flight = Flight(**flight_in.dict())
    db.add(flight)
    await db.commit()
    await db.refresh(flight)
    return FlightOut.from_orm(flight)

async def list_flights(db: AsyncSession) -> list[FlightOut]:
    result = await db.execute(select(Flight))
    flights = result.scalars().all()
    return [FlightOut.from_orm(f) for f in flights]
