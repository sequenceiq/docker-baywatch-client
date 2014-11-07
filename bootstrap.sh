#!/bin/bash

if [ ! -z $BAYWATCH_IP ]
then
	sed -i -E "s/cluster => 'logstash-es'/host => \"$BAYWATCH_IP\"/g" /etc/logstash/conf.d/output.conf
elif [ ! -z $BAYWATCH_CLUSTER_NAME ] 
then
	sed -i -E "s/cluster => 'logstash-es'/cluster => \'$BAYWATCH_CLUSTER_NAME\'/g" /etc/logstash/conf.d/output.conf
fi

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

