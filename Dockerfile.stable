FROM fedora:latest

MAINTAINER Jeffery Bagirimvano <jeffery.rukundo@gmail.com>

ENV TZ=America/Chicago

ENV SUMMARY="Munin Docker image" \
    DESCRIPTION="Munin is a networked resource monitoring tool (started in 2002) that can help analyze resource trends and what just happened to kill our performance? problems. It is designed to be very plug and play."

LABEL name="https://github.com/jefferyb/munin" \
      maintainer="jeffery.rukundo@gmail.com" \
      summary="${SUMMARY}" \
      description="${DESCRIPTION}" \
      url="https://github.com/jefferyb/munin" \
      help="For more information visit https://github.com/jefferyb/munin" \
      run='docker run -itd --rm --name munin -p '8080:8080' jefferyb/munin' \
      io.k8s.description="${DESCRIPTION}" \
      io.k8s.display-name="${SUMMARY}" \
      io.openshift.expose-services="8080" \
      io.openshift.tags="munin"

RUN \
  dnf upgrade -y && \
  DEBIAN_FRONTEND=noninteractive dnf install -y less munin

RUN \
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
  echo $TZ > /etc/timezone && \
  sed -i "s|Listen 80|Listen 8080|g" /etc/httpd/conf/httpd.conf && \
  sed -i "s|/var/www/html|/var/www/html/munin|g" /etc/httpd/conf/httpd.conf && \
  sed -i "s|root|apache|g" /etc/munin/munin-node.conf && \
  sed -i "s|/usr/share/httpd:/sbin/nologin|/usr/share/httpd:/bin/bash|g" /etc/passwd && \
  chown -R apache /var/log/munin-node /var/log/munin /var/run/munin /var/lib/munin /var/www/html/munin /run/httpd /var/log/httpd

USER apache

WORKDIR  /etc/munin

VOLUME /var/lib/munin /etc/munin/conf.d

EXPOSE 8080/tcp

CMD munin-node && \
    while :; do munin-cron; sleep 60; done & \
    httpd -DFOREGROUND
