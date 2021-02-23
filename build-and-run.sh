#/bin/sh

TAG=wnqueiroz/fiap-startup-one-postgres:13.1

docker build -t "$TAG" --no-cache .

docker rm -f fiap-startup-one-postgres-test
docker run --name fiap-startup-one-postgres-test \
    -p 5432:5432 \
    -e POSTGRES_USER=postgres \
    -e POSTGRES_PASSWORD=root \
    "$TAG"
