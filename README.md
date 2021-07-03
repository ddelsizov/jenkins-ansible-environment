# Jenkins Master and two Agent(slave) nodes brought up with the help of Vagrant and Ansible


It is a simple bundle of configuration and provisioning files for Vagrant+Virtualbox that deploys four servers.
Implementing different ways of provisioning and config, for excercise purposes - strictly home lab usage, not fit for prod. systems.

Vagrant deploys 4 VMs: 

  * Jenkins Master node
  * Two Jenkins agent(slave) nodes, running docker engines, joined in overlay network via docker swarm
  * Ansible node

Once vagrant spins up all four VMs, Ansible kick-starts provisioning of the machines.
  * It is expected that below task do not need human intervention, other than customizing the configurations before running "vagrant up":

  1. Deploy Jenkins master node, configures credentials and adds project templates for the builds, containing clean up, pull, build and test phases.
  2. Deploy Jenkins agent (slave) nodes, install docker on them, and join them in a docker swarm for overlay networking.
  3. Automatically pulls two docker images Webserver and DB from my other github repo ( https://github.com/ddelsizov/two-docker-images )
  4. Runs builds of the docker images found in the repository.
  5. Run the containers based on the built images
  6. Checks the repo for updates and rebuilds fresh images, once changes are detected.


I had to supply a hard copy of the jenkins slave role(https://github.com/lean-delivery/ansible-role-jenkins-slave) from my PC, during the provisioning phase, as it needed modifications in order to resolve a problem around CentOS8 and some python packages.

Jenkins should be accessible on http://localhost:8090 , the Webserver container, should be accessible on http://localhost:8888

# To Do

- Tighten the security - Currently it is all plaintext, non-ssh keys operation, strictly home lab usage.
- Deploy other useful plugins for Jenkins
- Build my own Jenkins, slave and docker roles, instead of using galaxy supplied roles.

