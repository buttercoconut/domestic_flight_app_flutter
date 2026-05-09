from sqlalchemy.ext.asyncio import AsyncSession
from ..models.user import User
from ..schemas.user import UserCreate, UserOut
from ..services.auth import get_password_hash

async def create_user(db: AsyncSession, user_in: UserCreate) -> UserOut:
    user = User(email=user_in.email, hashed_password=get_password_hash(user_in.password), name=user_in.name)
    db.add(user)
    await db.commit()
    await db.refresh(user)
    return UserOut.from_orm(user)

async def get_user_by_email(db: AsyncSession, email: str) -> User | None:
    result = await db.execute("SELECT * FROM users WHERE email = :email", {"email": email})
    return result.scalar_one_or_none()
