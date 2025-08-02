from collections.abc import Sequence

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from orm import Activity, Building, Organization


class OrganizationManager:
    @staticmethod
    async def get_by_id(
        session: AsyncSession,
        organization_id: int,
    ) -> Organization | None:
        return await session.scalar(
            select(Organization).where(Organization.id == organization_id),
        )

    @staticmethod
    async def get_by_building_id(
        session: AsyncSession,
        building_id: int,
    ) -> Sequence[Organization]:
        return (
            (
                await session.scalars(
                    select(Organization).where(Organization.building_id == building_id),
                )
            )
            .unique()
            .all()
        )

    @staticmethod
    async def get_by_activity(
        session: AsyncSession,
        activity: str,
    ) -> list[Organization]:
        result = set()
        for act in (
            await session.scalars(
                select(Activity)
                .options(selectinload(Activity.organizations))
                .where(
                    (Activity.name_1 == activity)
                    | (Activity.name_2 == activity)
                    | (Activity.name_3 == activity),
                ),
            )
        ).unique():
            result.update(act.organizations)
        return list(result)

    @staticmethod
    async def get_by_name(session: AsyncSession, name: str) -> Organization | None:
        return await session.scalar(
            select(Organization).where(Organization.name == name),
        )


class BuildingManager:
    @staticmethod
    async def get_all(session: AsyncSession) -> Sequence[Building]:
        return (await session.scalars(select(Building))).unique().all()
