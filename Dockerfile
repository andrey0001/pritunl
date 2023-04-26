FROM ubuntu:22.04

MAINTAINER Andrey Sorokin <andrey@sorokin.org>

RUN apt-get update -q &&\
    apt-get install -y --allow-unauthenticated apt-transport-https ca-certificates gnupg wget curl apt-utils locales

RUN echo "deb http://repo.pritunl.com/stable/apt jammy main" >>/etc/apt/sources.list.d/pritunl.list

RUN echo "deb http://repo.pritunl.com/stable/apt jammy main" >>/etc/apt/sources.list.d/pritunl.list &&\
    apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A &&\
    curl https://raw.githubusercontent.com/pritunl/pgp/master/pritunl_repo_pub.asc | apt-key add - &&\
    echo "deb https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" >>/etc/apt/sources.list.d/mongodb-org-6.0.list &&\
    wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | apt-key add - &&\
    apt-get update -q &&\
    locale-gen en_US en_US.UTF-8 &&\
    dpkg-reconfigure locales &&\
    ln -sf /usr/share/zoneinfo/UTC /etc/localtime &&\
    DEBIAN_FRONTEND=noninteractive apt-get update -q &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y --allow-unauthenticated pritunl mongodb-org &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y iptables  &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y --allow-unauthenticated dkms wireguard-dkms wireguard-tools &&\
    apt-get clean &&\
    apt-get -y -q autoclean &&\
    apt-get -y -q autoremove &&\
    rm -rf /tmp/* 

ADD start-pritunl /bin/start-pritunl

EXPOSE 9700
EXPOSE 1194/UDP
EXPOSE 1195/UDP

ENTRYPOINT ["/bin/start-pritunl"]

CMD ["/usr/bin/tail", "-f","/var/log/pritunl.log"]

