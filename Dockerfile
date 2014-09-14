FROM ubuntu:14.04
MAINTAINER SequenceIQ

RUN apt-get update
#RUN apt-get upgrade 
RUN apt-get install -y wget stress telnet
RUN wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
RUN echo 'deb http://packages.elasticsearch.org/logstashforwarder/debian stable main' | tee /etc/apt/sources.list.d/logstashforwarder.list
RUN apt-get update && apt-get install -y logstash-forwarder

#Insecure cert
RUN mkdir -p /etc/pki
ADD logstash-forwarder/tls /etc/pki/tls
RUN chmod -R 600 /etc/pki

#Config
ADD logstash-forwarder/logstash-forwarder.template /etc/logstash-forwarder.template

#Install collectd
RUN apt-get install -y collectd collectd-utils
ADD collectd/collectd.conf /etc/collectd/collectd.conf

#Bootstrap file
ADD bootstrap.sh /etc/bootstrap.sh
RUN chown root:root /etc/bootstrap.sh && chmod 700 /etc/bootstrap.sh

ENV BOOTSTRAP /etc/bootstrap.sh
