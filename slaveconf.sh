#!/bin/bash
echo "*** Add jenkins user and modify stuff"
sudo useradd jenkins
sudo echo "jenkins:secretpassword" | sudo chpasswd
sudo echo 'jenkins ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
sudo mkdir -p /opt/jenkins
sudo chmod jenkins:jenkins -R /opt/jenkins

echo "*** Add hosts"
echo "192.168.99.100 jenkins.home.lab jenkins" >> /etc/hosts
echo "192.168.99.101 slave.home.lab slave" >> /etc/hosts

echo "***Install Java  and additional python libs"
sudo dnf install -y java-11-openjdk-devel
sudo dnf install -y python3-libselinux python3-policycoreutils python3-libsemanage

echo "*** Add hosts, open firewall"

sudo echo "192.168.99.100 jenkins.home.lab jenkins" >> /etc/hosts
sudo echo "192.168.99.101 slave.home.lab slave" >> /etc/hosts
sudo firewall-cmd --add-port=80/tcp --permanent
sudo firewall-cmd --add-port=8888/tcp --permanent
sudo firewall-cmd --reload