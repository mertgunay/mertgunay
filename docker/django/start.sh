#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Usage: start.sh [PROCESS_TYPE](server/.<>./.<>./.<>.)"
  exit 1
fi

PROCESS_TYPE=$1

if [ "$PROCESS_TYPE" = "server" ]; then
  if [ "$DEBUG" = 1 ]; then
    echo "DEBUG MODE"
    gunicorn \
      --reload \
      --bind 0.0.0.0:8000 \
      --workers 3 \
      --log-level DEBUG \
      --access-logfile "-" \
      --error-logfile "-" \
      config.wsgi:application
  else
    echo "PRODUCTION MODE"
    gunicorn \
      --bind 0.0.0.0:8000 \
      --workers 3 \
      --access-logfile "-" \
      --error-logfile "-" \
      config.wsgi:application
  fi
fi
