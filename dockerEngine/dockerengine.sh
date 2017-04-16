#!/bin/bash
# dockerEngine setup by Shahab Khalid
#NOTE: Machine must have certificates in /root/certs/
yum install -y yum-utils

yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

yum-config-manager --enable docker-ce-edge

yum install docker-ce

sed -i '/ExecStart=\/usr\/bin\/dockerd/c\ExecStart=/usr/bin/dockerd --selinux-enabled --tls=true --tlscacert=/root/certs/ca.pem --tlscert=/root/certs/server-cert.pem --tlskey=/root/certs/server-key.pem -H tcp://0.0.0.0:2376' /usr/lib/systemd/system/docker.service

sudo firewall-cmd --zone=public --add-port=2376/tcp --permanent
sudo firewall-cmd --reload
echo 'export DOCKER_TLS_VERIFY="1"
  export DOCKER_HOST="tcp://localhost:2376"
  export DOCKER_CERT_PATH="/root/certs"' >> ~/.bashrc


source ~/.bashrc

systemctl daemon-reload

service docker restart
