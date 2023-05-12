FROM python:3.8-alpine

LABEL maintainer="Dmitry Tatarinov <d.tatarinov@bimlib.pro>"

USER root
WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apk update \
    && apk add postgresql-dev gcc python3-dev musl-dev libffi-dev

RUN pip install --upgrade pip

COPY ./backend/ ./

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY ./entrypoint.sh .

RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
