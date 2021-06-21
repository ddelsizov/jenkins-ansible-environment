# Jenkins and Jenkins agent + Ansible on Jenkins host

It is a simple configuration for Vagrant+virtualbox that deploys two servers: 

1. Jenkins master host + Ansible - Minimal Jenkins setup, not all common plugins are supplied. Passed ssh, git, github and docker plugins as an argument in the ansible playbook -> jenkins_plugins:

2. Jenkins slave host for which Ansible deploys Docker and Jenkins agent roles. 

Maine use cases would be to pull and build projects from GitHub repositories, mainly Dockerfiles to build and run image containers.

Of course - security is not priority on this project, as it is just a proof of concept and i made it for excersise at my home lab, while i study about functionalities of Jenkins, Docker and Ansible

# To Do

- Tighten the security 
- Deploy more useful plugins for Jenkins once identified
- Slave provsioning from the ansible playbook is failing on specific step from the role config. Potential work-around, implemented during Vagrant shell provisioning stage of the slave host ->

***
echo "*** Add jenkins user and modify stuff"
sudo useradd jenkins
sudo echo "jenkins:secretpassword" | sudo chpasswd
sudo echo 'jenkins ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
sudo mkdir -p /opt/jenkins
sudo chmod jenkins:jenkins -R /opt/jenkins
***
<-



