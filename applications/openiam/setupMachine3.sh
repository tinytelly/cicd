#!/bin/bash

#Generate Vault certificates
./generate.cert.sh

./setup.sh
docker images

./startup.sh
watch -n 5 'docker ps'


