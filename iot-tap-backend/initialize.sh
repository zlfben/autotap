#!/bin/sh

host="postgres"

until PGPASSWORD="password" psql -h $host -U "iftttuser" -c '\q' ifttt; do
  >&2 echo "DB unavailable - sleeping"
  sleep 1
done

>&2 echo "DB up - execute"
exec python3 manage.py runserver 0.0.0.0:8000
