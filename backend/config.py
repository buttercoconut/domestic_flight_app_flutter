"""Application configuration using Pydantic BaseSettings.

This module centralises all configuration values that can be overridden via
environment variables.  It is intentionally lightweight so that the rest of
the codebase can import ``settings`` without pulling in any heavy dependencies.
"""

from __future__ import annotations

from pathlib import Path
from typing import Optional

from pydantic import BaseSettings, Field


class Settings(BaseSettings):
    """Global application settings.

    The values are read from environment variables.  The ``env_file`` option
    allows a ``.env`` file to be used during local development.
    """

    # Database
    DATABASE_URL: str = Field(
        "sqlite:///./app.db", env="DATABASE_URL", description="SQLAlchemy database URL"
    )

    # FastAPI
    APP_NAME: str = Field("Domestic Flight Reservation API", env="APP_NAME")
    APP_VERSION: str = Field("0.1.0", env="APP_VERSION")

    # Secret key for password hashing (not used in this minimal example)
    SECRET_KEY: str = Field("changeme", env="SECRET_KEY")

    # Logging
    LOG_LEVEL: str = Field("INFO", env="LOG_LEVEL")

    class Config:
        env_file = ".env"
        env_file_encoding = "utf-8"


# Instantiate a single settings object that can be imported anywhere.
settings = Settings()
