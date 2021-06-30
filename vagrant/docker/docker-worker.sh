#!/bin/bash

echo "* Join the swarm ..."
sudo docker swarm join --token $(cat /vagrant/token.txt) --advertise-addr $(hostname -I | cut -d ' ' -f 2) 192.168.99.101:2377