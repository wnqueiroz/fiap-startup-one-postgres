FROM postgres:13.1

WORKDIR /usr/local/bin/

COPY ./scripts/00-create-multiple-postgresql-databases.sh /docker-entrypoint-initdb.d/