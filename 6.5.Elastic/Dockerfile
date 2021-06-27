FROM centos:7
LABEL version="1.0"
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
RUN yum update -y && \
    yum install -y perl-Digest-SHA && \
    yum install -y java-1.8.0-openjdk.x86_64

ADD https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.13.2-linux-x86_64.tar.gz /
ADD https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.13.2-linux-x86_64.tar.gz.sha512 /

RUN shasum -a 512 -c elasticsearch-7.13.2-linux-x86_64.tar.gz.sha512 && \
    tar -xzf elasticsearch-7.13.2-linux-x86_64.tar.gz && \
    rm -rf elasticsearch-7.13.2-linux-x86_64.tar.gz elasticsearch-7.13.2-linux-x86_64.tar.gz.sha512

RUN sed -i 's/#cluster.name: my-application/cluster.name: netology_test/g' /elasticsearch-7.13.2/config/elasticsearch.yml && \
    sed -i 's/#path.data: \/path\/to\/data/path.data: \/var\/lib\/elasticsearch\/data/g' /elasticsearch-7.13.2/config/elasticsearch.yml && \
#   sed -i 's/#network.host: 192.168.0.1/network.host: 0.0.0.0/g' /elasticsearch-7.13.2/config/elasticsearch.yml
    echo network.host: 127.0.0.1 >> /elasticsearch-7.13.2/config/elasticsearch.yml && \
    echo http.host: 0.0.0.0 >> /elasticsearch-7.13.2/config/elasticsearch.yml


RUN useradd elastic  && \
    mkdir -p /var/lib/elasticsearch/data && \
    chown -R elastic /elasticsearch-7.13.2 /var/lib/elasticsearch/data

VOLUME /var/lib/elasticsearch/data

EXPOSE 9200/tcp
EXPOSE 9300/tcp
USER elastic