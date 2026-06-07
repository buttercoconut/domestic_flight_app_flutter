# services/reservation_service.py
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from ..models.reservation import Reservation, ReservationCreate
from datetime import datetime

async def create_reservation(db: AsyncSession, res_in: ReservationCreate):
    reservation = Reservation(
        user_id=res_in.user_id,
        flight_id=res_in.flight_id,
        seat_number=res_in.seat_number,
        status="booked",
        created_at=datetime.utcnow(),
    )
    db.add(reservation)
    await db.commit()
    await db.refresh(reservation)
    return reservation

async def get_reservations_by_user(db: AsyncSession, user_id: int):
    result = await db.execute(select(Reservation).where(Reservation.user_id == user_id))
    return result.scalars().all()
