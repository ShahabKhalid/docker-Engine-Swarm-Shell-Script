#!/bin/bash
# dockerEngine setup by Shahab Khalid
#NOTE: Machine must have certificates
yum install -y yum-utils

yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

yum-config-manager --enable docker-ce-edge

yum install docker-ce

sed -i '/ExecStart=\/usr\/bin\/dockerd/c\ExecStart=/usr/bin/dockerd --selinux-enabled --tls=true --tlscacert=/root/ca.pem --tlscert=/root/server-cert.pem --tlskey=/root/server-key.pem -H tcp://0.0.0.0:2376' /usr/lib/systemd/system/docker.service

systemctl disable firewalld

echo '\nexport DOCKER_TLS_VERIFY="1"
  export DOCKER_HOST="tcp://localhost:2376"
  export DOCKER_CERT_PATH="/root"' >> ~/.bashrc


source .bashrc

systemctl daemon-reload

service docker restart
