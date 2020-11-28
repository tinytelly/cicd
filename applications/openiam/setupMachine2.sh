#!/bin/bash

docker --version

# Install docker-compose
curl -L https://github.com/docker/compose/releases/download/1.25.3/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose -version

# Install openiam
mkdir -p /etc/local/OpenIAM
git clone https://bitbucket.org/openiam/openiam-docker-compose.git
cd openiam-docker-compose
git checkout RELEASE-4.2.0.2
git branch

docker swarm init

#### turn off https
echo "export OPENIAM_RPROXY_HTTP=1" >> env.sh

echo "export DOCKER_COMPOSE_VERSION=3.2" >> env.sh
echo "export VAULT_JKS_PASSWORD=passwd00" >> env.sh
echo "export FLYWAY_ACTIVITI_PORT=3306" >> env.sh
echo "export FLYWAY_ACTIVITI_HOST=database" >> env.sh
echo "export FLYWAY_OPENIAM_PORT=3306" >> env.sh
echo "export FLYWAY_OPENIAM_HOST=database" >> env.sh

#### Logging
echo "export DOCKER_HOST_IP=$(ifconfig docker_gwbridge |awk '/inet/ {print $2}')" >> env.sh
echo "export SYS_LOG_HOST=openiam" >> env.sh
echo "export LOGGING_LEVEL=ERROR" >> env.sh

#### Set up email
echo "export SMTP_HOST=mailout.pillar.com.au" >> env.sh
echo "export SMTP_PORT=25" >> env.sh
echo "export SMTP_USERNAME=no_required_as_we_skip_auth" >> env.sh
echo "export SMTP_PASSWORD=no_required_as_we_skip_auth" >> env.sh
echo "export SMTP_AUTH=false" >> env.sh
echo "export SMTP_STARTTLS=false" >> env.sh
echo "export SMTP_DEFAULT_SENDER=matt.wood@mmc.com" >> env.sh
echo "export SMTP_SUBJECT_PREFIX=OpenIAM notifications" >> env.sh

