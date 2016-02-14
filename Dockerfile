FROM resin/rpi-raspbian:jessie

RUN apt-get update && \
  apt-get install apt-transport-https wget && \
  echo 'deb https://debian.fhem.de/stable ./' >> /etc/apt/sources.list && \
  echo 'Acquire::https::debian.fhem.de::Verify-Peer "false";' > /etc/apt/apt.conf.d/30nohttps && \
  wget --no-check-certificate -qO - https://debian.fhem.de/archive.key | apt-key add - && \
  apt-get update && \
  apt-get install -y fhem libwww-perl libsoap-lite-perl libxml-parser-lite-perl libjson-perl curl make && \
  curl -L http://cpanmin.us | perl - App::cpanminus
RUN cpanm Net::MQTT::Simple::SSL Net::MQTT::Constants Module::Pluggable

ADD fhem.cfg.template /opt/fhem/fhem.cfg.template
ADD fhem-entrypoint.sh /fhem-entrypoint.sh
RUN chown fhem /fhem-entrypoint.sh && chmod u+x /fhem-entrypoint.sh

WORKDIR /opt/fhem

CMD /fhem-entrypoint.sh

EXPOSE 8083 8084 8085 7072

VOLUME ["/data"]

ENV TERM=xterm
