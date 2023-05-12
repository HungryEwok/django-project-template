#!/bin/bash

python manage.py migrate --noinput || exit 1
echo "Миграции базы данных успешно выполнены"

python manage.py collectstatic --noinput || exit 1
echo "Команда collectstatic успешно выполнена"

gunicorn config.wsgi:application --workers 5 --threads 5 --bind 0.0.0.0:8000
echo "Приложение запущено"

exec "$@"
