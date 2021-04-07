#/bin/sh

TAG=wnqueiroz/fiap-startup-one-postgres:13.1

docker rmi "$TAG" -f

docker build -t "$TAG" --no-cache .

docker push $TAG

docker rmi "$TAG" -f