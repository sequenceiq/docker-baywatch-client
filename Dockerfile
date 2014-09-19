FROM ubuntu:14.04
MAINTAINER SequenceIQ

# Logstash 1.4.2

RUN apt-get update && apt-get install -y software-properties-common wget stress

#Install Java 7
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java7-installer

#Install collectd
RUN apt-get install -y collectd collectd-utils
ADD collectd/collectd.conf /etc/collectd/collectd.conf

#Install repo keys
RUN wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -

#Install Logstash
RUN echo 'deb http://packages.elasticsearch.org/logstash/1.4/debian stable main' | sudo tee /etc/apt/sources.list.d/logstash.list
RUN apt-get update && apt-get install -y logstash=1.4.2-1-2c0f5a1

#Workaround regarding ulimit privileges
RUN sed -i.bak '/set ulimit as/,+2 s/^/#/' /etc/init.d/logstash
RUN sed -i.bak 's/args=\"/args=\"-verbose /' /etc/init.d/logstash
RUN sed -i.bak 's/LS_USER=logstash/LS_USER=root/' /etc/init.d/logstash


#Configure Logstash INPUT and FILTER
#ADD logstash/shipper/shipper-nginx_access.conf /etc/logstash/conf.d/shipper-nginx_access.conf
ADD logstash/shipper/shipper-collectd.conf /etc/logstash/conf.d/shipper-collectd.conf
ADD	logstash/shipper/shipper-hadoop-metrics-datanode-metrics.conf /etc/logstash/conf.d/shipper-hadoop-metrics-datanode-metrics.conf
ADD	logstash/shipper/shipper-hadoop-metrics-maptask-metrics.conf /etc/logstash/conf.d/shipper-hadoop-metrics-maptask-metrics.conf
ADD	logstash/shipper/shipper-hadoop-metrics-mrappmaster-metrics.conf /etc/logstash/conf.d/shipper-hadoop-metrics-mrappmaster-metrics.conf
ADD	logstash/shipper/shipper-hadoop-metrics-namenode-metrics.conf /etc/logstash/conf.d/shipper-hadoop-metrics-namenode-metrics.conf
ADD	logstash/shipper/shipper-hadoop-metrics-nodemanager-metrics.conf /etc/logstash/conf.d/shipper-hadoop-metrics-nodemanager-metrics.conf
ADD logstash/shipper/shipper-hadoop-metrics-reducetask-metrics.conf /etc/logstash/conf.d/shipper-hadoop-metrics-reducetask-metrics.conf
ADD	logstash/shipper/shipper-hadoop-metrics-resourcemanager-metrics.conf /etc/logstash/conf.d/shipper-hadoop-metrics-resourcemanager-metrics.conf
ADD	logstash/shipper/shipper-hadoop-metrics-secondarynamenode-metrics.conf /etc/logstash/conf.d/shipper-hadoop-metrics-secondarynamenode-metrics.conf

#Configure Logstash PATTERN
RUN mkdir /etc/logstash/conf.d/patterns
ADD logstash/pattern/metrics /etc/logstash/conf.d/patterns/metrics

#Configure Logstash OUTPUT
ADD logstash/outputs/output.conf /etc/logstash/conf.d/output.conf


#Bootstrap file
ADD bootstrap.sh /etc/bootstrap.sh
RUN chown root:root /etc/bootstrap.sh && chmod 700 /etc/bootstrap.sh

ENV BOOTSTRAP /etc/bootstrap.sh
