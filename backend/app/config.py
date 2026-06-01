# app/config.py
# Configuration settings for the application
from pydantic import BaseSettings

class Settings(BaseSettings):
    app_name: str = "Domestic Flight Reservation"
    debug: bool = False
    database_url: str = "sqlite:///./flights.db"

settings = Settings()
