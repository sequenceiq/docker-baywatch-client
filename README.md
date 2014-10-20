# Logstash Forwarder on Docker

This image aims to provide monitoring functionality for Hadoop Clusters.

##Pull the container
```
docker pull sequenceiq/baywatch-client
```

##Run
```
docker run -d -p 8080:8080 -h amb0.mycorp.kom --name ambari-singlenode sequenceiq/ambari:1.6.0 --tag ambari-server=true
docker run -e BLUEPRINT=single-node-hdfs-yarn --link ambari-singlenode:ambariserver -t --rm --entrypoint /bin/sh sequenceiq/ambari:1.6.0 -c /tmp/install-cluster.sh

SRV1=$(docker inspect --format='{{index .Volumes "/var/log"}}' ambari-singlenode) && echo $SRV1
docker run -i -t -v $SRV1:/amb/log  sequenceiq/baywatch-client /etc/bootstrap.sh -bash
```
