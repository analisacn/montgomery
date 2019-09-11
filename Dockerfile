FROM python:3.7-alpine

ENV PYTHONPATH=/app/montgomery

ENV PYTHONUNBUFFERED=1

RUN addgroup -S montgomery && adduser -h /app/montgomery -S montgomery -G montgomery

COPY --chown=montgomery:montgomery requirements.txt /app/requirements.txt

RUN apk update --no-cache \
 && apk add --no-cache postgresql-dev \
 && apk add --no-cache --virtual .build-deps \
    gcc \
    python3-dev \
    musl-dev \
    libffi-dev \
 && pip install --no-cache-dir --disable-pip-version-check -r /app/requirements.txt \
 && apk del .build-deps \
 && rm -rf /app/requirements.txt

COPY --chown=montgomery:montgomery . /app/montgomery

WORKDIR /app/montgomery

EXPOSE 8000

USER montgomery
