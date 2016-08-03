FROM fedora:24

MAINTAINER Josh Berkus "josh@agliodbs.com"

# Fedora Layered Images labels
LABEL BZComponent="postgresql-container" \
  Name="fedora/postgresql-container" \
  Version="9.5" \
  Release="1" \
  Architecture="x86_64"

# create environment variables
ENV PG_MAJOR=9.5 \
  PG_VERSION=9.5.3 \
  POSTGRES_PASSWORD=postgres \
  APP_USER=app_user \
  APP_PASSWORD=app_pass \
  MAX_CONNECTIONS=50 \
  SHARED_BUFFERS=64MB

# add atomic labels
LABEL INSTALL="docker run -t -i --rm --privileged -u 0:0 -v /:/host --net=host --ipc=host --pid=host -e LOGDIR=/var/log/\"\${NAME}\" -e DATADIR=/var/lib/\"\${NAME}\" -e IMAGE=\"\${IMAGE}\" -e NAME=\"\${NAME}\" \${IMAGE} /atomic/install.sh" \
    UNINSTALL="docker run -t -i --rm --privileged -u 0:0 -v /:/host --net=host --ipc=host --pid=host -e LOGDIR=/var/log/\"\${NAME}\" -e DATADIR=/var/lib/\"\${NAME}\" -e IMAGE=\"\${IMAGE}\" -e NAME=\"\${NAME}\" \${IMAGE} /atomic/uninstall.sh" \
    RUN="docker run -p 5432:5432 -d -v /var/lib/\${NAME}:/var/lib/pgsql/ \${IMAGE}"

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

COPY postgres95/ /docker/

EXPOSE 5432

ENTRYPOINT ["/docker/entrypoint.sh"]
CMD ["postgres","-i","-l","-D","/var/lib/pgsql/data"]
