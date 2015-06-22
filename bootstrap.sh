#!/bin/bash
: ${BAYWATCH_IP:?"Please set the BAYWATCH_IP environment variable!"}
: ${BAYWATCH_CLUSTER_NAME:?"Please set the BAYWATCH_CLUSTER_NAME environment variable!"}
: ${BAYWATCH_CLIENT_HOSTNAME:?"Please set the BAYWATCH_HOSTNAME environment variable!"}
: ${BAYWATCH_CLIENT_PRIVATE_IP:?"Please set the BAYWATCH_PRIVATE_IP environment variable!"}

sed -i -E "s/host => 'es-host'/host => \"$BAYWATCH_IP\"/g" /etc/logstash/conf.d/output.conf
sed -i -E "s/cluster => 'logstash-es'/cluster => \'$BAYWATCH_CLUSTER_NAME\'/g" /etc/logstash/conf.d/output.conf
sed -i -E "s/'client_hostname'/\'$BAYWATCH_CLIENT_HOSTNAME\'/g" /etc/logstash/conf.d/shipper-common.conf
sed -i -E "s/'client_private_ip'/\'$BAYWATCH_CLIENT_PRIVATE_IP\'/g" /etc/logstash/conf.d/shipper-common.conf

service logstash start

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
