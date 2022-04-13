FROM python:3

# set envs
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# install poetry
RUN pip install -U pip \
    && apt-get update \
    && apt install -y curl netcat \
    && curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
ENV PATH="${PATH}:/root/.poetry/bin"

# install deps
WORKDIR /code
ENV POETRY_VIRTUALENVS_CREATE false
ADD poetry.lock /code/poetry.lock
ADD pyproject.toml /code/pyproject.toml
RUN --mount=type=cache,target=/root/.cache/pypoetry poetry install --no-interaction --no-ansi
