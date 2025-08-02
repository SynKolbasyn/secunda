from collections.abc import AsyncGenerator
from http import HTTPStatus
from os import environ
from typing import Annotated

from fastapi import Depends, FastAPI, HTTPException, Query
from sqlalchemy.ext.asyncio import AsyncSession, async_sessionmaker, create_async_engine

from dto import Organization
from managers import BuildingManager, OrganizationManager
from utils import check_api_key, distance

engine = create_async_engine(
    environ.get("DB_CONNECTION", "sqlite+aiosqlite:///database.sqlite3"),
    echo=True,
)
session_maker = async_sessionmaker(engine, expire_on_commit=False)


app = FastAPI()


async def db_session() -> AsyncGenerator[AsyncSession]:
    async with session_maker.begin() as session:
        yield session


session_di = Annotated[AsyncSession, Depends(db_session)]


@app.get("/buildings/{building_id}/organizations")
async def get_organizations_by_building_id(
    api_key: Annotated[str, Query()],
    building_id: int,
    session: session_di,
) -> list[Organization]:
    check_api_key(api_key)
    return list(await OrganizationManager.get_by_building_id(session, building_id))


@app.get("/activities/organizations")
async def get_organizations_by_activity(
    api_key: Annotated[str, Query()],
    session: session_di,
    activity: Annotated[str, Query()],
) -> list[Organization]:
    check_api_key(api_key)
    return list(await OrganizationManager.get_by_activity(session, activity))


@app.get("/organizations/nearby")
async def get_organizations_nearby(
    api_key: Annotated[str, Query()],
    session: session_di,
    latitude: Annotated[float, Query()],
    longitude: Annotated[float, Query()],
    radius: Annotated[float, Query()],
) -> list[Organization]:
    check_api_key(api_key)
    result = []
    for building in await BuildingManager.get_all(session):
        if (
            distance(building.latitude, building.longitude, latitude, longitude)
            <= radius
        ):
            result.extend(building.organizations)
    return result


@app.get("/organizations/search")
async def search_organization(
    api_key: Annotated[str, Query()],
    session: session_di,
    name: Annotated[str, Query()],
) -> Organization:
    check_api_key(api_key)
    organization = await OrganizationManager.get_by_name(session, name)
    if organization is not None:
        return organization
    raise HTTPException(
        status_code=HTTPStatus.NOT_FOUND,
        detail="Organization not found",
    )


@app.get("/organizations/{organization_id}")
async def get_organization(
    api_key: Annotated[str, Query()],
    organization_id: int,
    session: session_di,
) -> Organization:
    check_api_key(api_key)
    organization = await OrganizationManager.get_by_id(session, organization_id)
    if organization is not None:
        return organization
    raise HTTPException(
        status_code=HTTPStatus.NOT_FOUND,
        detail="Organization not found",
    )
