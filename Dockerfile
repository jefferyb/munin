FROM ubuntu:latest

MAINTAINER Jeffery Bagirimvano <jeffery.rukundo@gmail.com>

ENV SUMMARY="Munin Docker image" \
    DESCRIPTION="Munin is a networked resource monitoring tool (started in 2002) that can help analyze resource trends and what just happened to kill our performance? problems. It is designed to be very plug and play."

### Atomic/OpenShift Labels - https://github.com/projectatomic/ContainerApplicationGenericLabels
LABEL name="https://github.com/jefferyb/munin" \
      maintainer="jeffery.rukundo@gmail.com" \
      summary="${SUMMARY}" \
      description="${DESCRIPTION}" \
### Required labels above - recommended below
      url="https://github.com/jefferyb/munin" \
      help="For more information visit https://github.com/jefferyb/munin" \
      run='docker run -itd --rm --name munin -p '4948:4948' jefferyb/munin' \
      io.k8s.description="${DESCRIPTION}" \
      io.k8s.display-name="${SUMMARY}" \
      io.openshift.expose-services="4948" \
      io.openshift.tags="munin"

RUN useradd -ms /bin/bash munin

RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y libdbd-sqlite3-perl libdbi-perl \
    libfile-copy-recursive-perl libhtml-template-perl \
    libhtml-template-pro-perl libhttp-server-simple-perl \
    libio-socket-inet6-perl liblist-moreutils-perl \
    liblog-dispatch-perl libmodule-build-perl libnet-server-perl \
    libnet-server-perl libnet-snmp-perl librrds-perl \
    libnet-ssleay-perl libparams-validate-perl liburi-perl \
    libwww-perl libxml-dumper-perl \
    libdbd-pg-perl libfile-readbackwards-perl \
    libfile-slurp-perl libio-stringy-perl libnet-dns-perl \
    libnet-ip-perl libtest-deep-perl libtest-differences-perl \
    libtest-longstring-perl libtest-mockmodule-perl \
    libtest-mockobject-perl libtest-perl-critic-perl \
    libxml-libxml-perl libxml-parser-perl \
    git make

ENV APP_ROOT=/opt/app-root
ENV PATH=/usr/local/bin:${APP_ROOT}/sandbox/bin:${PATH} HOME=${APP_ROOT}

RUN git clone https://github.com/munin-monitoring/munin ${APP_ROOT} && \
    cd ${APP_ROOT} && \
    perl Build.PL && \
    ./Build installdeps

RUN mkdir -p ${APP_ROOT} && \
    chown -R munin:munin ${APP_ROOT} && \
    chmod -R u+x /usr/local/bin && \
    chgrp -R 0 ${APP_ROOT} && \
    chmod -R g=u ${APP_ROOT} /etc/passwd

COPY bin/ /usr/local/bin/

### Containers should NOT run as root as a good practice
USER munin
WORKDIR ${APP_ROOT}

RUN dev_scripts/install node && \
    dev_scripts/disable_taint && \
    dev_scripts/run munin-update && \
    rm -f ${APP_ROOT}/sandbox/etc/munin-conf.d/node.ipv6.sandbox.local.conf && \
    cp -fr ${APP_ROOT}/sandbox/var/lib ${APP_ROOT}/sandbox/var/lib-init

COPY munin-conf.d/ ${APP_ROOT}/sandbox/etc/munin-conf.d/

EXPOSE 4948

VOLUME ${APP_ROOT}/sandbox/var/lib

ENTRYPOINT [ "uid_entrypoint" ]

CMD start-munin

# ref: http://guide.munin-monitoring.org/en/latest/develop/environment.html
# ref: https://github.com/RHsyseng/container-rhel-examples/blob/master/starter-arbitrary-uid/Dockerfile.centos7