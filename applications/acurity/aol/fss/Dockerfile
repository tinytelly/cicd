FROM DOCKER_REGISTRY_URL/docker/acurity-aol:DOCKER_TAG

ADD aol-settings.tar.gz /usr/local/tomcat/conf/

ARG GITCOMMIT
RUN echo $GITCOMMIT