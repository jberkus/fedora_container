FROM fedora:24

MAINTAINER Josh Berkus "josh@agliodbs.com"

# create environment variables
ENV PG_MAJOR=9.5 \
  PG_VERSION=9.5.3 \
  POSTGRES_PASSWORD=postgres \
  APP_USER=app_user \
  APP_PASSWORD=app_pass \
  MAX_CONNECTIONS=50 \
  SHARED_BUFFERS=64MB

# explicitly set user/group IDs
RUN groupadd -r postgres --gid=2001 && \
  useradd -r -g postgres --uid=2001 postgres

# install packages
RUN dnf -y install openssl && \
    dnf -y install postgresql-server \
    postgresql-contrib \
    sudo && \
    dnf clean all

# add data volume
VOLUME /var/lib/pgsql/data

# set up PostgreSQL data directory
RUN mkdir /docker && \
  chmod 755 /docker

COPY postgres95/* /docker/

EXPOSE 5432

ENTRYPOINT ["/docker/entrypoint.sh"]
CMD ["postgres","-i","-l","-D","/var/lib/pgsql/data"]
