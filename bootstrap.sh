#!/bin/bash

cp /etc/logstash-forwarder.template /etc/logstash-forwarder

service collectd start
nohup /opt/logstash-forwarder/bin/logstash-forwarder -config /etc/logstash-forwarder -from-beginning=true > /var/log/start-logstash-forwarder.log &


if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi


CMD ["/etc/bootstrap.sh", "-d"]
