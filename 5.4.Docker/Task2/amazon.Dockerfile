FROM amazoncorretto
LABEL maintainer="Alex Pedan"
LABEL version="1.0"

ADD https://pkg.jenkins.io/redhat-stable/jenkins.repo /etc/yum.repos.d/jenkins.repo

RUN rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key && \
    yum update -y && \
    yum install -y jenkins

EXPOSE 8080/tcp
EXPOSE 50000

USER jenkins

CMD ["-jar", "/usr/lib/jenkins/jenkins.war"]
ENTRYPOINT ["java"]