# Jenkins and Jenkins agent + Ansible on Jenkins host

It is a simple configuration for Vagrant+virtualbox that deploys two servers: 

1. Jenkins master host + Ansible

2. Jenkins slave host for which Ansible deploys Docker and Jenkins slave roles. 

The ansible playbook takes care of initial Jenkins configuration where it:

- Configures Jenkis master as it supplies a list of basic plugins: ssh, git, github, docker, credential
- Configures slave credential in master with id "ci_slave" via cli in default credential domain and store via shell -> credential.sh and credential.xml
- Configures Jenkins slave host with slave and docker roles from ansible galaxy.

Main use cases would be to pull and build projects from GitHub repositories, mainly Dockerfiles to build and run image containers.

Of course - security is not priority on this project, as it is just a proof of concept and i made it for excersise at my home lab, while i study about functionalities of Jenkins, Docker and Ansible

# To Do

- Tighten the security 
- Deploy more useful plugins for Jenkins once identified
- Clean remaning hickups here and there



