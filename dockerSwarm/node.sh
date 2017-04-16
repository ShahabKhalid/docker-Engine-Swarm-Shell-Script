#!/bin/bash
# dockerSwarm node setup by Shahab Khalid
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

#opening port
sudo firewall-cmd --zone=public --add-port=2375/tcp --permanent
sudo firewall-cmd --reload
