from http import HTTPStatus
from math import atan2, cos, radians, sin, sqrt
from os import environ

from fastapi import HTTPException


def distance(lat_1: float, lon_1: float, lat_2: float, lon_2: float) -> float:
    phi1 = radians(lat_1)
    phi2 = radians(lat_2)
    delta_phi = radians(lat_2 - lat_1)
    delta_lambda = radians(lon_2 - lon_1)

    a = sin(delta_phi / 2) ** 2 + cos(phi1) * cos(phi2) * sin(delta_lambda / 2) ** 2
    distance = 2 * atan2(sqrt(a), sqrt(1 - a))

    return 6_371_000 * distance


API_KEY = environ["API_KEY"]


def check_api_key(key: str) -> None:
    if key != API_KEY:
        raise HTTPException(
            HTTPStatus.UNAUTHORIZED,
            "You have no permission to access this resource.",
        )
