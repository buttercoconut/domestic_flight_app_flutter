"""FastAPI application entry point."""

from fastapi import FastAPI
from .routes import user, flight, reservation

app = FastAPI(title="Domestic Flight Reservation API")

# Include routers
app.include_router(user.router, prefix="/users", tags=["users"])
app.include_router(flight.router, prefix="/flights", tags=["flights"])
app.include_router(reservation.router, prefix="/reservations", tags=["reservations"])

# Root endpoint
@app.get("/")
async def read_root():
    return {"message": "Welcome to Domestic Flight Reservation API"}
