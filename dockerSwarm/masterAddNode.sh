#!/bin/bash
# dockerSwarm add node setup by Shahab Khalid
# USAGE : sh masterAddNode.sh [nodeIp] [Token]
docker -H $1:2375 --tls --tlscacert=/root/certs/ca.pem --tlscert=/root/certs/cert.pem --tlskey=/root/certs/key.pem  run --restart=unless-stopped -d swarm join --advertise=$1:2375  token://$2
