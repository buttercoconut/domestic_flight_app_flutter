"""User service logic."""

from sqlalchemy.orm import Session
from .. import models
from ..schemas import UserCreate, UserOut

async def create_user(db: Session, user_in: UserCreate):
    hashed = "hashed" + user_in.password  # placeholder
    db_user = models.User(email=user_in.email, hashed_password=hashed, full_name=user_in.full_name)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return UserOut.from_orm(db_user)

async def get_user(db: Session, user_id: int):
    return db.query(models.User).filter(models.User.id == user_id).first()
