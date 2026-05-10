"""Flight related endpoints.

Provides CRUD and a simple search by departure/arrival airports.
"""

from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from sqlalchemy import and_

from ..database import SessionLocal
from ..models.flight import Flight, FlightCreate, FlightRead

router = APIRouter()

async def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.post("/", response_model=FlightRead, status_code=status.HTTP_201_CREATED)
async def create_flight(flight_in: FlightCreate, db: Session = Depends(get_db)):
    flight = Flight(**flight_in.dict())
    db.add(flight)
    db.commit()
    db.refresh(flight)
    return flight

@router.get("/{flight_id}", response_model=FlightRead)
async def read_flight(flight_id: int, db: Session = Depends(get_db)):
    flight = db.get(Flight, flight_id)
    if not flight:
        raise HTTPException(status_code=404, detail="Flight not found")
    return flight

@router.put("/{flight_id}", response_model=FlightRead)
async def update_flight(flight_id: int, flight_in: FlightCreate, db: Session = Depends(get_db)):
    flight = db.get(Flight, flight_id)
    if not flight:
        raise HTTPException(status_code=404, detail="Flight not found")
    for var, value in flight_in.dict().items():
        setattr(flight, var, value)
    db.commit()
    db.refresh(flight)
    return flight

@router.delete("/{flight_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_flight(flight_id: int, db: Session = Depends(get_db)):
    flight = db.get(Flight, flight_id)
    if not flight:
        raise HTTPException(status_code=404, detail="Flight not found")
    db.delete(flight)
    db.commit()
    return None

@router.get("/search", response_model=list[FlightRead])
async def search_flights(
    departure_airport_id: int | None = None,
    arrival_airport_id: int | None = None,
    db: Session = Depends(get_db),
):
    query = db.query(Flight)
    if departure_airport_id:
        query = query.filter(Flight.departure_airport_id == departure_airport_id)
    if arrival_airport_id:
        query = query.filter(Flight.arrival_airport_id == arrival_airport_id)
    return query.all()
