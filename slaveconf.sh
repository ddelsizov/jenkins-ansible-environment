#!/bin/bash
echo "*** Install Git"
sudo dnf -y install git

echo "***Install Java"
sudo dnf install -y java-11-openjdk-devel

echo "*** Add hosts, open firewall"

sudo echo "192.168.99.100 jenkins.home.lab jenkins" >> /etc/hosts
sudo echo "192.168.99.101 slave.home.lab slave" >> /etc/hosts
sudo firewall-cmd --add-port=80/tcp --permanent
sudo firewall-cmd --add-port=8888/tcp --permanent
sudo firewall-cmd --reload