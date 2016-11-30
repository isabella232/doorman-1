#!/bin/bash

set -e
set -o nounset

host="$1"
shift
cmd="$@"

user=$POSTGRES_USER
export PGPASSWORD=$POSTGRES_PASSWORD

until psql -h "$host" -U "$user" -c '\l'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

>&2 echo "Postgres is up - executing command '$cmd'"
exec $cmd
