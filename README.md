# Jenkins and Jenkins slave + Ansible on Jenkins host

It is a simple configuration for Vagrant+virtualbox that deploys two servers: 

1. Jenkins master host + Ansible - Minimal setup, not all common plugins are supplied. Can be passed as an argument in the ansible playbook -> jenkins_plugins:
2. Jenkins slave host for which Ansible deploys Docker role. The idea is that Jenkins will be using the slave host as a place to build and run containers.

Of course - security is not priority on this project, as it is just a proof of concept and i made it for excersise at my home lab, while i study about functionalities of Jenkins, Docker and Ansible


To be done: 

Automate slave config (if possible), ssh key exchanges and other various tasks.
