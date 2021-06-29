# Jenkins Master and Agent(slave) brought up with the help of Vagrant and ansible which is hosted along with Jenkins master.



It is a simple bundle of configuration and provisioning files for Vagrant+Virtualbox that deploys two servers.
Implementing different ways of provisioning and config, for excercise purposes - strictly home lab usage, not fit for prod. systems.

    Jenkins master host + Ansible
    Jenkins slave host for which Ansible deploys Docker and Jenkins slave roles.

Ansible is deployed on the Jenkins master host, where with the help of a playbook takes care of below tasks:

    -> Installs and configures Jenkis master server via role from ansible galaxy, 
        -> Setups admin credentials and installs few useful plugins and their dependencies from a list.

    -> Configures Jenkins slave host with docker and slave roles from ansible galaxy.
    
           Files: 
           master-playbook.yml, 
           slave-playbook.yml, 
           master-requirements.yml,
           slave-requierements.yml
           inventory, ansible.cfg

    -> Configures slave credentials in master host via Jenkins cli.
           Credentials id is "ci_slave" 
           
           Files: credential.sh and credential.xml
           
    -> Creates a job from createjob.sh, which is expected to be build once the slave host is up.

Simple project for job is added with repository ( https://github.com/ddelsizov/basic-docker-poc.git) that runs shell commands that Build, Runs and Tests simple apache container serving basic webpage.

Test is done via: 


Should be customized where needed.
Defined variables, that can be modified:

Vagrantfile

    $configureMaster and $configureSlave:
    "jenkins:secretpassword"


credential.xml

    jenkins
    secretpassword

In playbooks:

    jenkins_admin_username:
    jenkins_admin_password:

    master_username:
    master_password:
    slave_linux_jenkins_cred_id: ci_slave
    slave_linux_jenkins_username:
    slave_linux_jenkins_password:


# To Do

- Group files in respective folders for better aestetics
- Tighten the security - Currently it is all plaintext, non-ssh keys operation for use in home lab.
- Deploy more useful plugins for Jenkins once identified
- Clean up remaning hickups here and there, group files within directories, tidy up the deployment


