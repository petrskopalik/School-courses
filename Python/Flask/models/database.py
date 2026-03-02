from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, relationship
from sqlalchemy import String, Text, DateTime, TIMESTAMP, func, Boolean, ForeignKey


class Base(DeclarativeBase):
    pass

db = SQLAlchemy(model_class=Base)

class Users(db.Model):
    __tablename__ = "users"

    id: Mapped[int] = mapped_column(primary_key=True)
    username: Mapped[str] = mapped_column(String(30), unique=True, nullable=False)
    password: Mapped[str] = mapped_column(Text, nullable=False)
    role: Mapped[str] = mapped_column(String(10), default='user', nullable=False)
    authorized: Mapped[bool] = mapped_column(Boolean, default=False, nullable=False)
    recipes: Mapped[list["Recipes"]] = relationship(
        back_populates="creator",
        cascade="all, delete-orphan"
    )

class Recipes(db.Model):
    __tablename__ = "recipes"

    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(50), nullable=False)
    text: Mapped[str] = mapped_column(Text, nullable=False)
    created: Mapped[DateTime] = mapped_column(TIMESTAMP, server_default=func.now())
    creator_id: Mapped[int] = mapped_column(ForeignKey("users.id"), nullable=False)
    creator: Mapped[Users] = relationship(back_populates="recipes")