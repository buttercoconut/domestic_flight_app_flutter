"""User routes."""

from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from .. import models, services
from ..config import settings
from ..dependencies import get_db

router = APIRouter()

@router.post("/register")
async def register_user(user: models.UserCreate, db: Session = Depends(get_db)):
    return await services.user_service.create_user(db, user)

@router.get("/{user_id}")
async def get_user(user_id: int, db: Session = Depends(get_db)):
    return await services.user_service.get_user(db, user_id)
