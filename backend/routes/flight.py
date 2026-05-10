"""Flight routes."""

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from .. import services
from ..dependencies import get_db

router = APIRouter()

@router.get("/")
async def search_flights(origin: str, destination: str, date: str, db: Session = Depends(get_db)):
    return await services.flight_service.search_flights(db, origin, destination, date)
