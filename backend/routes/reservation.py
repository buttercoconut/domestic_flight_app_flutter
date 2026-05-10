"""Reservation endpoints.

Creates a reservation, confirms it (stubbed payment), and allows cancellation.
"""

from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from ..database import SessionLocal
from ..models.reservation import Reservation, ReservationCreate, ReservationRead, ReservationStatus
from ..models.payment import Payment, PaymentCreate, PaymentRead

router = APIRouter()

async def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.post("/", response_model=ReservationRead, status_code=status.HTTP_201_CREATED)
async def create_reservation(res_in: ReservationCreate, db: Session = Depends(get_db)):
    reservation = Reservation(**res_in.dict())
    db.add(reservation)
    db.commit()
    db.refresh(reservation)
    return reservation

@router.get("/{reservation_id}", response_model=ReservationRead)
async def read_reservation(reservation_id: int, db: Session = Depends(get_db)):
    res = db.get(Reservation, reservation_id)
    if not res:
        raise HTTPException(status_code=404, detail="Reservation not found")
    return res

@router.post("/{reservation_id}/confirm", response_model=ReservationRead)
async def confirm_reservation(reservation_id: int, db: Session = Depends(get_db)):
    res = db.get(Reservation, reservation_id)
    if not res:
        raise HTTPException(status_code=404, detail="Reservation not found")
    if res.status != ReservationStatus.PENDING:
        raise HTTPException(status_code=400, detail="Only pending reservations can be confirmed")
    # Stub payment – in real life call gateway
    payment = Payment(
        reservation_id=res.id,
        amount=res.flight.price * res.seats,
        method="credit_card",
        status="paid",
    )
    db.add(payment)
    res.status = ReservationStatus.CONFIRMED
    db.commit()
    db.refresh(res)
    return res

@router.post("/{reservation_id}/cancel", response_model=ReservationRead)
async def cancel_reservation(reservation_id: int, db: Session = Depends(get_db)):
    res = db.get(Reservation, reservation_id)
    if not res:
        raise HTTPException(status_code=404, detail="Reservation not found")
    if res.status == ReservationStatus.CANCELLED:
        raise HTTPException(status_code=400, detail="Already cancelled")
    res.status = ReservationStatus.CANCELLED
    db.commit()
    db.refresh(res)
    return res
