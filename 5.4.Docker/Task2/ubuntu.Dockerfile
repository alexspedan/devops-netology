FROM ubuntu
LABEL maintainer="Alex Pedan"
LABEL version="2.0"

ADD https://pkg.jenkins.io/debian-stable/jenkins.io.key /

RUN apt-get update -y && \
    apt-get install -y gnupg ca-certificates && \
    apt-key add /jenkins.io.key && \
    bash -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list' && \
    apt-get update -y && \
    apt-get install -y openjdk-8-jdk openjdk-8-jre jenkins

EXPOSE 8080/tcp
EXPOSE 5000

USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean:1.24.6 docker-workflow:1.26"
WORKDIR "/usr/share/jenkins"
CMD ["-jar", "jenkins.war"]
ENTRYPOINT ["java"]
