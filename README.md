# Logstash Forwarder on Docker

This image aims to provide monitoring functionality for Hadoop Clusters.

##Build
```
docker build --rm -t elk_ubu_client .
```

##Run
```
SRV1=$(docker inspect amb0 | grep "vfs/dir" | awk '/"(.*)"/ { gsub(/"/,"",$2); print $2 }')
docker run -i -t -v $SRV1:/amb0/log  elk_ubu_client /etc/bootstrap.sh -bash
```
