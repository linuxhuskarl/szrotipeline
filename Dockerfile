FROM jenkins/agent:alpine
USER root
RUN apk add cmake g++ make
USER jenkins
