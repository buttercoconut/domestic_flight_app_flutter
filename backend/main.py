from fastapi import FastAPI
from app.api.routes import router as api_router
from app.database import engine, Base

# Create database tables
Base.metadata.create_all(bind=engine)

app = FastAPI(title="Domestic Flight Reservation API", description="API for domestic flight booking and management", version="0.1.0")

app.include_router(api_router, prefix="/api")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
