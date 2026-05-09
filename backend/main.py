from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from .config import settings
from .routes import user, flight, reservation

app = FastAPI(title=settings.PROJECT_NAME, version=settings.VERSION)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(user.router, prefix="/api/v1/users", tags=["users"])
app.include_router(flight.router, prefix="/api/v1/flights", tags=["flights"])
app.include_router(reservation.router, prefix="/api/v1/reservations", tags=["reservations"])

@app.get("/")
async def root():
    return {"message": "Welcome to Domestic Flight App API"}
