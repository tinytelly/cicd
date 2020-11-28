#!/bin/bash
gitNumber=$(git rev-parse HEAD)
humanReadableDate=$(date '+%Y-%m-%d_%H-%M-%S') #tag with date to get a fresh image on each build

docker login -u $DOCKER_REGISTRY_USERNAME -p $DOCKER_REGISTRY_PASSWORD $DOCKER_REGISTRY_URL

docker build --build-arg GITCOMMIT=${gitNumber} -t "$DOCKER_REGISTRY_URL/docker/acurity-aol:${humanReadableDate}" .
docker push $DOCKER_REGISTRY_URL/docker/acurity-aol:${humanReadableDate}

cd fss
sed -i -e "s/DOCKER_REGISTRY_URL/$DOCKER_REGISTRY_URL/g" Dockerfile
sed -i -e "s/DOCKER_TAG/$humanReadableDate/g" Dockerfile
docker build --build-arg GITCOMMIT=${gitNumber} -t "$DOCKER_REGISTRY_URL/docker/acurity-aol:18.2.2-fss-${humanReadableDate}" .
docker push $DOCKER_REGISTRY_URL/docker/acurity-aol:18.2.2-fss-${humanReadableDate}