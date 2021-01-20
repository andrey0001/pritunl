FROM centos:7

MAINTAINER Andrey Sorokin <andrey@sorokin.org>

ADD mongodb-org-4.2.repo /etc/yum.repos.d/mongodb-org-4.2.repo
ADD pritunl.repo /etc/yum.repos.d/pritunl.repo


RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm &&\
    gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 7568D9BB55FF9E5287D586017AE645C0CF8E292A &&\
    gpg --armor --export 7568D9BB55FF9E5287D586017AE645C0CF8E292A > key.tmp; rpm --import key.tmp; rm -f key.tmp &&\
    yum -y install pritunl mongodb-org &&\
    yum clean all

ADD start-pritunl /bin/start-pritunl

EXPOSE 9700
EXPOSE 1194/UDP
EXPOSE 1195/UDP

ENTRYPOINT ["/bin/start-pritunl"]

CMD ["/usr/bin/tail", "-f","/var/log/pritunl.log"]

