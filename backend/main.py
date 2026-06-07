# main.py
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from .routes import user, flight, reservation
from .config import settings

app = FastAPI(title="Domestic Flight Reservation API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(user.router, prefix="/users", tags=["users"])
app.include_router(flight.router, prefix="/flights", tags=["flights"])
app.include_router(reservation.router, prefix="/reservations", tags=["reservations"])

@app.get("/")
async def root():
    return {"message": "Welcome to Domestic Flight Reservation API"}
