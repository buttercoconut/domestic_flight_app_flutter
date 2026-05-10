"""Database setup for the backend.

Uses SQLAlchemy with a SQLite database for simplicity.  In a production
environment you would replace the connection string with a Postgres or
MySQL URL.
"""

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base

# SQLite in‑memory for demo; change to a file or external DB in prod.
DATABASE_URL = "sqlite:///./domestic_flight.db"

engine = create_engine(DATABASE_URL, connect_args={"check_same_thread": False})
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

# Create tables if they don't exist.
# Import all models so that Base.metadata knows about them.
from . import models  # noqa: F401

# Expose a helper to run migrations.

def init_db() -> None:
    """Create all tables.
    """
    Base.metadata.create_all(bind=engine)

# If this module is executed directly, initialise the DB.
if __name__ == "__main__":
    init_db()
    print("Database initialised at", DATABASE_URL)
