#!/bin/bash

echo "* Initialize swarm ..."
sudo docker swarm init --advertise-addr 192.168.99.101

echo "* Save the worker join token to a file ..."
sudo docker swarm join-token -q worker > /vagrant/token.txt