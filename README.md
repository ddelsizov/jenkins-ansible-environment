# Jenkins Master and Agent(slave) brought up with the help of Vagrant and Ansible


It is a simple bundle of configuration and provisioning files for Vagrant+Virtualbox that deploys two servers.
Implementing different ways of provisioning and config, for excercise purposes - strictly home lab usage, not fit for prod. systems.

    Jenkins master host + Ansible
    Jenkins slave host for which Ansible deploys Docker and Jenkins slave roles.
    
        File:
        Vagrantfile

Ansible is taking care of the following tasks:

    -> Installs and configures Jenkis master server via role from ansible galaxy, 
        -> Setups admin credentials and installs few useful plugins and their dependencies from a list.
        
         Files: 
           master-playbook.yml, 
           master-requirements.yml,
           inventory, ansible.cfg,
           

    -> Configures Jenkins slave host with docker and slave roles from ansible galaxy.
    
           Files: 
           slave-playbook.yml, 
           slave-requierements.yml
           inventory, ansible.cfg

    -> Configures slave credentials in master host via Jenkins cli.
           Credentials id is "ci_slave" 
           
           Files: 
           credential.sh 
           credential.xml
           
    -> Creates a job on Master from createjob.sh file. 
    The same job is packed in a Jenkins file in the target repo, but here some steps are pushed in the job as scripts.
            
            Files:
            cleanup.sh (stops all containers, removes them, clears the project folder). This way we ensure clean build folders and environment.
            test.sh (runs curl to check http status)
    
    The job should run a build and test once the slave host is up. 

Simple project for job is added with repository ( https://github.com/ddelsizov/basic-docker-poc.git) that runs shell commands that Build, Runs and Tests simple apache container serving basic webpage.

Test is done with the help of curl, that parses the response code of the container: 

    #!/bin/bash
    options='-o /dev/null -w %{http_code} -sfI'
    page="http://localhost:80"
    sleep 60
    outstr=$(curl $options $page)
    retVal=$?
    [[ $retVal -eq 0 ]] || { echo "ERROR should have been able to pull $page, retVal=$retVal, code=$outstr"; exit 4; }
    echo "OK pulling from $page successful, retVal=$retVal, code=$outstr"

Everythong can be customized where needed.

The end result webpage after the project is build should be visible from host at => http://localhost:8888

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

- Tighten the security - Currently it is all plaintext, non-ssh keys operation, strictly home lab usage.
- Deploy other useful plugins for Jenkins
- Add second docker host / jenkins slave to build and run another image (Maybe DB + Web) 
- Add another host with Nagios for monitoring of the infrastructure

