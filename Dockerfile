FROM ubuntu:16.04

MAINTAINER Andrey Sorokin <andrey@sorokin.org>

ADD repo.list /etc/apt/sources.list.d/repo.list

RUN locale-gen en_US en_US.UTF-8 &&\
    dpkg-reconfigure locales &&\
    ln -sf /usr/share/zoneinfo/UTC /etc/localtime &&\
    apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 42F3E95A2C4F08279C4960ADD68FA50FEA312927 &&\
    apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A &&\
    apt-get update -q &&\
    apt-get install -y software-properties-common python-software-properties &&\
    apt-get install -y pritunl mongodb-org &&\
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

