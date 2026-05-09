from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from ..models.reservation import Reservation
from ..schemas.reservation import ReservationCreate, ReservationOut

async def create_reservation(db: AsyncSession, res_in: ReservationCreate) -> ReservationOut:
    reservation = Reservation(**res_in.dict())
    db.add(reservation)
    await db.commit()
    await db.refresh(reservation)
    return ReservationOut.from_orm(reservation)

async def list_reservations(db: AsyncSession) -> list[ReservationOut]:
    result = await db.execute(select(Reservation))
    reservations = result.scalars().all()
    return [ReservationOut.from_orm(r) for r in reservations]
