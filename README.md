# Logstash Forwarder on Docker

This image aims to provide monitoring functionality for Hadoop Clusters. For reference check this [blog post](http://blog.sequenceiq.com/blog/2014/10/07/hadoop-monitoring/).

##Pull the container
```
docker pull sequenceiq/baywatch-client
```

##Run
```
docker run -d -p 8080:8080 -h amb0.mycorp.kom --name ambari-singlenode sequenceiq/ambari:1.6.0 --tag ambari-server=true
docker run -e BLUEPRINT=single-node-hdfs-yarn --link ambari-singlenode:ambariserver -t --rm --entrypoint /bin/sh sequenceiq/ambari:1.6.0 -c /tmp/install-cluster.sh

SRV1=$(docker inspect --format='{{index .Volumes "/var/log"}}' ambari-singlenode) && echo $SRV1
docker run -i -t -v $SRV1:/amb/log -e BAYWATCH_IP=<my_baywatch_server_ip> -e BAYWATCH_CLUSTER_NAME=es-cluster-name -e BAYWATCH_CLIENT_HOSTNAME=client-host-name -e BAYWATCH_CLIENT_PRIVATE_IP=client-ip-address sequenceiq/baywatch-client /etc/bootstrap.sh -bash
```
