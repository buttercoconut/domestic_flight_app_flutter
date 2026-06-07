# routes/user.py
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select

from ..models.user import User, UserRead, UserCreate
from ..config import settings
from ..services.user_service import get_user_by_email, create_user

router = APIRouter()

@router.post("/", response_model=UserRead)
async def register_user(user_in: UserCreate, db: AsyncSession = Depends(get_db)):
    existing = await get_user_by_email(db, user_in.email)
    if existing:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Email already registered")
    user = await create_user(db, user_in)
    return UserRead.from_orm(user)

# Dependency placeholder
async def get_db():
    pass
