FROM postgres:13.1

WORKDIR /usr/local/bin/

ARG POSTGRES_MULTIPLE_DATABASES=ms_company,ms_user,ms_appointment,ms_gamification
ENV POSTGRES_MULTIPLE_DATABASES=${POSTGRES_MULTIPLE_DATABASES}

# Variables needed at runtime to configure postgres and run the initdb scripts
ENV POSTGRES_DB ''
ENV POSTGRES_USER ''
ENV POSTGRES_PASSWORD ''

COPY ./dumps/ /docker-entrypoint-initdb.d/dumps

COPY ./scripts/00-create-multiple-postgresql-databases.sh /docker-entrypoint-initdb.d/
COPY ./scripts/01-restore-dumps.sh /docker-entrypoint-initdb.d/
