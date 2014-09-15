# Logstash Forwarder on Docker

This image aims to provide monitoring functionality for Hadoop Clusters.

##Build
```
docker build -t elk_ubu_client .
```

##Run
```
SRV1=$(docker inspect elk_ubu | grep "vfs/dir" | awk '/"(.*)"/ { gsub(/"/,"",$2); print $2 }') && echo $SRV1
docker run -i -t -v $SRV1:/elk_ubu/log  elk_ubu_client /etc/bootstrap.sh -bash

#docker run -i -t  elk_ubu_client /etc/bootstrap.sh -bash
```
