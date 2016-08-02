#!/bin/bash
set -e

if [ "$1" = 'postgres' ]; then

  if [ ! -d "/var/lib/pgsql/data" ]; then
    mkdir /var/lib/pgsql/data
  fi

  chown postgres:postgres /var/lib/pgsql/data
  chmod 700 /var/lib/pgsql/data
  sudo -E -u postgres /docker/pgstart.sh $@

fi

exec "$@"
