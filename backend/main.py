"""FastAPI application entry point.

This file creates the FastAPI instance, includes the router modules and
provides a simple health‑check endpoint.
"""

from fastapi import FastAPI

from . import database
from .routes import reservation

app = FastAPI(title="Domestic Flight Reservation API")

# Initialise database tables on startup.
@app.on_event("startup")
def on_startup() -> None:
    database.init_db()

# Include routers.
app.include_router(reservation.router, prefix="/reservations", tags=["reservations"])

# Simple health‑check.
@app.get("/health")
async def health() -> dict[str, str]:
    return {"status": "ok"}

# If run directly, use uvicorn.
if __name__ == "__main__":
    import uvicorn

    uvicorn.run("domestic_flight_app_flutter.backend.main:app", host="0.0.0.0", port=8000, reload=True)
