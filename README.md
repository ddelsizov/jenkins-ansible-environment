# Jenkins Master and Agent(slave) brought up with the help of Vagrant and ansible which is hosted along with Jenkins master.

It is a simple configuration for Vagrant+virtualbox that deploys two servers: 

1. Jenkins master host + Ansible

2. Jenkins slave host for which Ansible deploys Docker and Jenkins slave roles. 

Ansible is deployed on the Jenkins master host, where with the help of a playbook takes care of 

- Installs and configures Jenkis master server, setups admin credentials and supplies a list of few base plugins: ssh, git, github, docker, credential and others
 -> playbook.yml, requirements.yml, inventory, ansible.cfg
 
 - Configures slave credential in master host via Jenkins cli with id "ci_slave" in default credential domain and store.
 -> credential.sh and credential.xml
 
- Configures Jenkins slave host with slave and docker roles from ansible galaxy.
 -> playbook.yml

Main use cases would be to pull and build projects from GitHub repositories, mainly Dockerfiles to be build and run as containers.

Of course - security is not priority on this project, as it is just a proof of concept and i made it for excersise at my home lab, while i study about functionalities of Jenkins, Docker and Ansible

# To Do

- Tighten the security 
- Deploy more useful plugins for Jenkins once identified
- Clean remaning hickups here and there
- Setup Jobs and projects programatically



