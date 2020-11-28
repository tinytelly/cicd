# see : https://github.com/jenkinsci/docker/blob/master/README.md

FROM jenkins/jenkins:lts

ARG GITCOMMIT
RUN echo $GITCOMMIT

# if we want to install via apt
USER root

#see : https://docs.docker.com/engine/install/debian/
RUN apt-get update && apt-get -y install \
                          apt-transport-https \
                          ca-certificates \
                          curl \
                          gnupg-agent \
                          software-properties-common

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) \
       stable"
RUN apt-get update
RUN apt-get -y install docker-ce docker-ce-cli containerd.io

RUN echo "DOCKER_OPTS='$DOCKER_OPTS --insecure-registry jfrog-container-registry-artifactory-nginx.artifactory-jcr.svc.cluster.local'" >> /etc/default/docker

# we don't drop back to jenkins so that we can run the docker.sock from the host
#USER jenkins