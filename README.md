# Logstash Forwarder on Docker

This image aims to provide monitoring functionality for Hadoop Clusters.

##Build
```
docker build -t elk_ubu_client .
```

##Run
```
docker run -d -p 8080:8080 -h amb0.mycorp.kom --name ambari-singlenode sequenceiq/ambari:1.7.0-ea --tag ambari-server=true
docker run -e BLUEPRINT=single-node-hdfs-yarn --link ambari-singlenode:ambariserver -t --rm --entrypoint /bin/sh sequenceiq/ambari:1.7.0-ea -c /tmp/install-cluster.sh

SRV1=$(docker inspect --format='{{index .Volumes "/var/log"}}' ambari-singlenode) && echo $SRV1
docker run -i -t -v $SRV1:/amb/log  elk_ubu_client /etc/bootstrap.sh -bash
```
