from pydantic import BaseSettings

class Settings(BaseSettings):
    PROJECT_NAME: str = "Domestic Flight App"
    VERSION: str = "0.1.0"
    DATABASE_URL: str = "postgresql+asyncpg://user:password@localhost:5432/domestic_flight"
    SECRET_KEY: str = "supersecretkey"
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30

settings = Settings()
