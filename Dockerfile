FROM ubuntu:14.04
MAINTAINER SequenceIQ

RUN apt-get update && apt-get install -y wget stress
RUN wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
RUN echo 'deb http://packages.elasticsearch.org/logstashforwarder/debian stable main' | tee /etc/apt/sources.list.d/logstashforwarder.list
RUN apt-get update && apt-get install -y logstash-forwarder

#Insecure cert
ADD logstash-forwarder/tls /etc/pki/tls


#Add to initd
#wget https://raw.github.com/elasticsearch/logstash-forwarder/master/logstash-forwarder.init
ADD logstash-forwarder/logstash-forwarder.init /etc/init.d/logstash-forwarder
RUN cd /etc/init.d/ &&  chmod +x logstash-forwarder

#Config
ADD logstash-forwarder/logstash-forwarder.template /etc/logstash-forwarder.template

#Bootstrap file
ADD bootstrap.sh /etc/bootstrap.sh
RUN chown root:root /etc/bootstrap.sh && chmod 700 /etc/bootstrap.sh

ENV BOOTSTRAP /etc/bootstrap.sh
