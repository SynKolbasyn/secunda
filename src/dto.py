from pydantic import BaseModel, model_serializer, model_validator
from pydantic_extra_types.phone_numbers import PhoneNumber


class Activity(BaseModel):
    id: int
    name_1: str | None = None
    name_2: str | None = None
    name_3: str | None = None

    class Config:
        from_attributes = True


class Building(BaseModel):
    id: int
    address: str
    latitude: float
    longitude: float

    class Config:
        from_attributes = True


class Phone(BaseModel):
    number: PhoneNumber

    @model_serializer
    def serializer(self) -> str:
        return self.number

    @model_validator(mode="before")
    @classmethod
    def validator(cls, data: object) -> object:
        if isinstance(data, str):
            return {"number": data}
        return data

    class Config:
        from_attributes = True


class Organization(BaseModel):
    id: int
    name: str
    building: Building
    phones: list[Phone]
    activities: list[Activity]

    class Config:
        from_attributes = True
