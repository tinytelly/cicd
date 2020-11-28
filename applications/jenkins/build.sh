#!/bin/bash

repository="tinytelly/jenkins-plus"
gitNumber=$(git rev-parse HEAD)

image="${repository}:0.0.3"

echo ">>>> Building image ${image} <<<<"

docker build --build-arg GITCOMMIT=${gitNumber} -t ${image} .
docker push ${image}