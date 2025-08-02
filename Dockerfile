FROM ghcr.io/astral-sh/uv:alpine

ENV UV_LINK_MODE=copy
ENV UV_COMPILE_BYTECODE=1

WORKDIR /secunda/

COPY ./.python-version ./
RUN uv python install

COPY ./pyproject.toml ./
RUN uv sync --no-dev

COPY ./src/ ./src/
COPY ./alembic.ini ./
COPY ./migrations/ ./migrations/

CMD ["sh", "-c", "uv run --no-dev alembic upgrade head && PYTHONPATH=./src/ uv run --no-dev fastapi run --port 80 ./src/main.py"]