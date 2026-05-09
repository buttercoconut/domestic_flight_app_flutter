from pydantic import BaseModel

class ReservationCreate(BaseModel):
    user_id: int
    flight_id: int
    seat_number: str

class ReservationOut(BaseModel):
    id: int
    user_id: int
    flight_id: int
    seat_number: str
    status: str

    class Config:
        orm_mode = True
