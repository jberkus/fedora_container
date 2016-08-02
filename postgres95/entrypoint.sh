#!/bin/bash
set -e

if [ "$1" = 'postgres' ]; then
    if [ -z "$(ls -A "/var/lib/pgsql/data")" ]; then
        echo "initializing database(s)"
        /usr/bin/initdb -D /var/lib/pgsql/data
        /etc/ssl/certs/make-dummy-cert /var/lib/pgsql/data/server.crt
        ln -s /var/lib/pgsql/data/server.crt /var/lib/pgsql/data/server.key
        /usr/bin/pg_ctl -w -D /var/lib/pgsql/data start
        /usr/bin/psql -q -c "ALTER ROLE postgres PASSWORD '${POSTGRES_PASSWORD}'"
        /usr/bin/psql -q -c "CREATE ROLE ${APP_USER} PASSWORD '${APP_PASSWORD}' LOGIN"
        /usr/bin/psql -q -c "CREATE DATABASE ${APP_USER} OWNER ${APP_USER}"
        echo "initialization complete, restarting ..."
        /usr/bin/pg_ctl -w -D /var/lib/pgsql/data stop
    fi

    exec "$@" "-c" "shared_buffers=${SHARED_BUFFERS}" "-N" "${MAX_CONNECTIONS}" \
    "-c" "log_destination=stderr" "-c" "logging_collector=off"

fi

exec "$@"
