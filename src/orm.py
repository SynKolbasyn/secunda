from sqlalchemy import Column, ForeignKey, Table
from sqlalchemy.orm import Mapped, declarative_base, mapped_column, relationship

Base = declarative_base()


organization_activity = Table(
    "organization_activity",
    Base.metadata,
    Column("organization_id", ForeignKey("organizations.id"), primary_key=True),
    Column("activity_id", ForeignKey("activities.id"), primary_key=True),
)


class Organization(Base):
    __tablename__ = "organizations"

    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    name: Mapped[str] = mapped_column(unique=True)

    building_id: Mapped[int] = mapped_column(ForeignKey("buildings.id"))
    building: Mapped["Building"] = relationship(
        back_populates="organizations",
        lazy="joined",
    )

    phones: Mapped[list["Phone"]] = relationship(
        back_populates="organization",
        lazy="joined",
    )
    activities: Mapped[list["Activity"]] = relationship(
        secondary=organization_activity,
        back_populates="organizations",
        lazy="joined",
    )


class Phone(Base):
    __tablename__ = "phones"

    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)

    number: Mapped[str] = mapped_column(unique=True)

    organization_id: Mapped[int] = mapped_column(ForeignKey("organizations.id"))
    organization: Mapped[Organization] = relationship(
        back_populates="phones",
        lazy="joined",
    )


class Building(Base):
    __tablename__ = "buildings"

    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    address: Mapped[str]
    latitude: Mapped[float]
    longitude: Mapped[float]
    organizations: Mapped[list[Organization]] = relationship(
        back_populates="building",
        lazy="selectin",
    )


class Activity(Base):
    __tablename__ = "activities"

    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)

    name_1: Mapped[str] = mapped_column(nullable=True)
    name_2: Mapped[str] = mapped_column(nullable=True)
    name_3: Mapped[str] = mapped_column(nullable=True)

    organizations: Mapped[list[Organization]] = relationship(
        secondary=organization_activity,
        back_populates="activities",
        lazy="joined",
    )
