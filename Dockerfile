FROM ubuntu:16.04

MAINTAINER Andrey Sorokin <andrey@sorokin.org>

ADD repo.list /etc/apt/sources.list.d/repo.list

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv E162F504A20CDF15827F718D4B7C549A058F8B6B &&\
    apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A &&\
    apt-get update -q &&\
    apt-get install -y --allow-unauthenticated apt-utils locales &&\
    locale-gen en_US en_US.UTF-8 &&\
    dpkg-reconfigure locales &&\
    ln -sf /usr/share/zoneinfo/UTC /etc/localtime &&\
    DEBIAN_FRONTEND=noninteractive apt-get update -q &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common python-software-properties &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y pritunl mongodb-org &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y iptables &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y wireguard-dkms wireguard-tool &&\
    apt-get clean &&\
    apt-get -y -q autoclean &&\
    apt-get -y -q autoremove &&\
    rm -rf /tmp/*

ADD start-pritunl /bin/start-pritunl

EXPOSE 9700
EXPOSE 1194
EXPOSE 1195

ENTRYPOINT ["/bin/start-pritunl"]

CMD ["/usr/bin/tail", "-f","/var/log/pritunl.log"]

