FROM jenkins/agent:alpine
USER root
RUN apk add cmake
USER jenkins
