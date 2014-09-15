#!/bin/bash

service collectd start
service logstash start

#/opt/logstash/bin/logstash agent -f /etc/logstash/conf.d/ --configtest
#nohup /opt/logstash/bin/logstash agent -f /etc/logstash/conf.d/ > /var/log/logstash/logstash.stdout &



if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi


CMD ["/etc/bootstrap.sh", "-d"]
