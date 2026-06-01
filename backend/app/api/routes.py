from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List

from app.database import get_db
from app.schemas import FlightCreate, Flight, FlightOut
from app.models import Flight as FlightModel

router = APIRouter()

@router.post("/flights", response_model=FlightOut, status_code=status.HTTP_201_CREATED)
def create_flight(flight: FlightCreate, db: Session = Depends(get_db)):
    db_flight = FlightModel(**flight.dict())
    db.add(db_flight)
    db.commit()
    db.refresh(db_flight)
    return db_flight

@router.get("/flights", response_model=List[FlightOut])
def list_flights(db: Session = Depends(get_db)):
    flights = db.query(FlightModel).all()
    return flights

@router.get("/flights/{flight_id}", response_model=FlightOut)
def get_flight(flight_id: int, db: Session = Depends(get_db)):
    flight = db.query(FlightModel).filter(FlightModel.id == flight_id).first()
    if not flight:
        raise HTTPException(status_code=404, detail="Flight not found")
    return flight

@router.put("/flights/{flight_id}", response_model=FlightOut)
def update_flight(flight_id: int, flight: FlightCreate, db: Session = Depends(get_db)):
    db_flight = db.query(FlightModel).filter(FlightModel.id == flight_id).first()
    if not db_flight:
        raise HTTPException(status_code=404, detail="Flight not found")
    for key, value in flight.dict().items():
        setattr(db_flight, key, value)
    db.commit()
    db.refresh(db_flight)
    return db_flight

@router.delete("/flights/{flight_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_flight(flight_id: int, db: Session = Depends(get_db)):
    db_flight = db.query(FlightModel).filter(FlightModel.id == flight_id).first()
    if not db_flight:
        raise HTTPException(status_code=404, detail="Flight not found")
    db.delete(db_flight)
    db.commit()
    return None
