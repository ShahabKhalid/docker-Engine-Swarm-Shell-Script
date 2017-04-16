#!/bin/bash
# dockerSwarm master setup by Shahab Khalid
#NOTE: Machine must have certificates in /root/certs/
yum install -y yum-utils

yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

yum-config-manager --enable docker-ce-edge

yum install docker-ce

sed -i '/ExecStart=\/usr\/bin\/dockerd/c\ExecStart=/usr/bin/dockerd --selinux-enabled  -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock --tlsverify --tlscacert=/root/certs/ca.pem --tlscert=/root/certs/server-cert.pem --tlskey=/root/certs/server-key.pem' /usr/lib/systemd/system/docker.service

systemctl daemon-reload
rm -rf /var/run/docker.pid
rm -rf /var/run/docker.sock
service docker restart

#docker pull swarm

a=$(docker run --rm swarm create)
docker run --restart=unless-stopped -d -p 3375:2375  -v /root/certs:/certs:Z swarm manage --tls --tlscacert=/certs/ca.pem --tlscert=/certs/server-cert.pem --tlskey=/certs/server-key.pem token://$a

sudo firewall-cmd --zone=public --add-port=3375/tcp --permanent
sudo firewall-cmd --reload

echo "Token is"  $a

