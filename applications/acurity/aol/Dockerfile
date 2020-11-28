FROM  tomcat:8-jdk8-openjdk

COPY war/aol-war-partsaa /usr/local/tomcat/webapps/
COPY war/aol-war-partsab /usr/local/tomcat/webapps/
RUN cat /usr/local/tomcat/webapps/aol-war-parts* > /usr/local/tomcat/webapps/aol.war
RUN rm /usr/local/tomcat/webapps/aol-war-parts*

ARG GITCOMMIT
RUN echo $GITCOMMIT