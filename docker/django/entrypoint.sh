#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

export DATABASE_URL="postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}"

if [ -z "${POSTGRES_USER}" ]; then
  base_postgres_image_default_user='postgres'
  export POSTGRES_USER="${base_postgres_image_default_user}"
fi

postgres_ready() {
  python <<END
import sys
from psycopg2 import connect
from psycopg2.errors import OperationalError
try:
    connect(
        dbname="${POSTGRES_DB}",
        user="${POSTGRES_USER}",
        password="${POSTGRES_PASSWORD}",
        host="${POSTGRES_HOST}",
        port="${POSTGRES_PORT}",
    )
except OperationalError:
    sys.exit(-1)
sys.exit(0)
END
}

redis_ready() {
    python << END
import sys
from redis import Redis
from redis import RedisError
try:
    redis = Redis.from_url("${REDIS_URL}", db=0)
    redis.ping()
except RedisError:
    sys.exit(-1)
END
}

until postgres_ready; do
  echo >&2 "Waiting for PostgreSQL to become available..."
  sleep 1
done
echo >&2 "PostgreSQL is available"

#until redis_ready; do
#  echo >&2 "Waiting for Redis to become available..."
#  sleep 1
#done
#echo >&2 "Redis is available"

exec "$@"