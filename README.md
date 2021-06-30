# Jenkins Master and two Agent(slave) nodes brought up with the help of Vagrant and Ansible


It is a simple bundle of configuration and provisioning files for Vagrant+Virtualbox that deploys four servers.
Implementing different ways of provisioning and config, for excercise purposes - strictly home lab usage, not fit for prod. systems.

Vagrant deploys 4 VMs: 

  * Jenkins Master node
  * Two Agent(slave) nodes
  * Ansible node

Once vagrant spins up all four VMs, Ansible kick-starts provisioning of the machines.
  * It is expected that below task do not need human intervention:

  1. Deploy jenkins slave roles+docker on the slave hosts
  2. Configure credentials and setup two projects in Jenkins Master
  3. Automatically pulls two docker images from github repo ( https://github.com/ddelsizov/two-docker-images )
  4. Runs builds of the docker images found in the repository.
  5. Run the containers based on the built images
  6. Checks the repo for changes

Clean up procedure is implemented in the projects so that builds will stop and remove containers, will clean up the work-directory and will pull fresh copy of the git repo before building and running the images again.

Of course, it can be modified and updated as needed.

Jenkins should be accessible on http://localhost:8090 , the Webserver container, should be accessible on http://localhost:8888

# To Do

- Tighten the security - Currently it is all plaintext, non-ssh keys operation, strictly home lab usage.
- Deploy other useful plugins for Jenkins
- Add another host with Nagios for monitoring of the infrastructure

