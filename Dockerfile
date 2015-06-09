FROM ubuntu:14.04

MAINTAINER Dag Einar Monsen <me@dag.im>

RUN apt-get update
RUN echo deb http://pkg.jenkins-ci.org/debian binary/ >> /etc/apt/sources.list
RUN apt-get install -y wget
RUN wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
RUN apt-get update
RUN apt-get install -y jenkins git qemu-user-static maven

# now we install docker in docker - thanks to https://github.com/jpetazzo/dind
RUN echo deb http://archive.ubuntu.com/ubuntu precise universe > /etc/apt/sources.list.d/universe.list
RUN apt-get update -qq
RUN apt-get install -qqy iptables ca-certificates
ADD https://get.docker.io/builds/Linux/x86_64/docker-latest /usr/local/bin/docker
ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/docker /usr/local/bin/wrapdocker

# expose jenkins 
ENV JENKINS_HOME /var/jenkins_home
VOLUME /var/jenkins_home
EXPOSE 8080

# expose docker volume
VOLUME /var/lib/docker

# Make sure we exec to pass on signals correctly
CMD wrapdocker && exec java -jar /usr/share/jenkins/jenkins.war
