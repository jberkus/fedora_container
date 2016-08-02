FROM fedora:24

MAINTAINER Josh Berkus "josh@agliodbs.com"

# explicitly set user/group IDs
RUN groupadd -r postgres --gid=2001 && \
  useradd -r -g postgres --uid=2001 postgres

# install packages
RUN dnf -y install openssl && \
    dnf -y install postgresql-server \
    postgresql-contrib && \
    dnf clean all

# set up PostgreSQL data directory
USER postgres
RUN /usr/bin/initdb -D /var/lib/pgsql/data && \
  /etc/ssl/certs/make-dummy-cert /var/lib/pgsql/data/server.crt && \
  ln -s /var/lib/pgsql/data/server.crt /var/lib/pgsql/data/server.key
COPY postgres95/pg_hba.conf /var/lib/pgsql/data

EXPOSE 5432

CMD ["/usr/bin/postgres","-i","-l","-D","/var/lib/pgsql/data"]
