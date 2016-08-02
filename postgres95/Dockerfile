FROM fedora:24

MAINTAINER Josh Berkus "josh@agliodbs.com"

RUN dnf -y install postgresql-server
RUN dnf -y install postgresql-contrib

USER postgres
RUN /usr/bin/initdb -D /var/lib/pgsql/data
COPY postgres95/pg_hba.conf /var/lib/pgsql/data

EXPOSE 5432

CMD ["/usr/bin/postgres","-i","-D","/var/lib/pgsql/data"]
