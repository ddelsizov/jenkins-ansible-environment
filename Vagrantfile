# -*- mode: ruby -*-
# vi: set ft=ruby :

$configureAnsible = <<-SCRIPT
echo "* Add hosts ..."
echo "192.168.99.100 jenkins.home.lab jenkins" >> /etc/hosts
echo "192.168.99.101 slave.home.lab slave" >> /etc/hosts
echo "192.168.99.102 slave1.home.lab slave1" >> /etc/hosts
echo "192.168.99.103 ansible.home.lab ansible" >> /etc/hosts

echo "* Install Ansible ..."
dnf install -y epel-release
dnf install -y ansible

echo "* Set Ansible configuration in /etc/ansible/ansible.cfg ..."
cp /vagrant/ansible.cfg /etc/ansible/ansible.cfg

echo "* Set Ansible global inventory in /etc/ansible/hosts ..."
cp /vagrant/hosts /etc/ansible/hosts

echo "* Copy Ansible playbooks in /playbooks/ ..."
cp -R /vagrant/playbooks /playbooks

echo "* Copy Slave role to /etc/ansible/roles ..."
cp -avr /playbooks/lean_delivery.jenkins_slave /etc/ansible/roles

echo "* Install Ansible role(s) from galaxy for jenkins and docker in /etc/ansible/roles ..."
ansible-galaxy install geerlingguy.jenkins -p /etc/ansible/roles
ansible-galaxy install geerlingguy.docker -p /etc/ansible/roles
ansible-galaxy install geerlingguy.java -p /etc/ansible/roles

echo "* Execute Ansible Playbooks ..."
ansible-playbook /playbooks/install-all.yml
SCRIPT

$configureMaster = <<-SCRIPT
echo "* Add hosts ..."
	echo "192.168.99.100 jenkins.home.lab jenkins" >> /etc/hosts
	echo "192.168.99.101 slave.home.lab slave" >> /etc/hosts
	echo "192.168.99.102 slave1.home.lab slave1" >> /etc/hosts
	echo "192.168.99.103 ansible.home.lab ansible" >> /etc/hosts

	sudo firewall-cmd --add-port=8080/tcp --permanent
	sudo firewall-cmd --reload
	sudo useradd jenkins
	sudo echo "jenkins:secretpassword" | sudo chpasswd
	sudo echo 'jenkins ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
	sudo dnf install git -y
SCRIPT

$configureSlave = <<-SCRIPT
	echo "*** Add jenkins user and modify stuff"
	sudo useradd jenkins
	sudo echo "jenkins:secretpassword" | sudo chpasswd
	sudo echo 'jenkins ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
	sudo mkdir -p /opt/jenkins
	sudo chown jenkins:jenkins -R /opt/jenkins

	echo "*** Add hosts"
	echo "192.168.99.100 jenkins.home.lab jenkins" >> /etc/hosts
	echo "192.168.99.101 slave.home.lab slave" >> /etc/hosts
	echo "192.168.99.102 slave1.home.lab slave1" >> /etc/hosts
	echo "192.168.99.103 ansible.home.lab ansible" >> /etc/hosts

	echo "***Install Java  and additional python libs"
	sudo dnf install java-11-openjdk-devel -y
	sudo dnf install python3 -y
	sudo dnf install python3-libselinux -y

	echo "*** Open firewall"

	sudo firewall-cmd --add-port=80/tcp --permanent
	sudo firewall-cmd --add-port=8888/tcp --permanent
	sudo firewall-cmd --add-port=8889/tcp --permanent
	sudo firewall-cmd --add-port=3306/tcp --permanent
	sudo firewall-cmd --add-port=2377/tcp --permanent
	sudo firewall-cmd --add-port=7946/tcp --permanent
	sudo firewall-cmd --add-port=7946/udp --permanent
    sudo firewall-cmd --add-port=4789/tcp --permanent
	sudo firewall-cmd --reload
SCRIPT

$configureSlave1 = <<-SCRIPT
	echo "*** Add jenkins user and modify stuff"
	sudo useradd jenkins1
	sudo echo "jenkins1:secretpassword1" | sudo chpasswd
	sudo echo 'jenkins1 ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
	sudo mkdir -p /opt/jenkins1
	sudo chown jenkins1:jenkins1 -R /opt/jenkins

	echo "*** Add hosts"
	echo "192.168.99.100 jenkins.home.lab jenkins" >> /etc/hosts
	echo "192.168.99.101 slave.home.lab slave" >> /etc/hosts
	echo "192.168.99.102 slave1.home.lab slave1" >> /etc/hosts
	echo "192.168.99.103 ansible.home.lab ansible" >> /etc/hosts
	
	echo "***Install Java  and additional python libs"
	sudo dnf install java-11-openjdk-devel -y
	sudo dnf install python3 -y
	sudo dnf install python3-libselinux -y

	echo "*** Open firewall"

	sudo firewall-cmd --add-port=80/tcp --permanent
	sudo firewall-cmd --add-port=8888/tcp --permanent
	sudo firewall-cmd --add-port=8889/tcp --permanent
	sudo firewall-cmd --add-port=3306/tcp --permanent
	sudo firewall-cmd --add-port=2377/tcp --permanent
	sudo firewall-cmd --add-port=7946/tcp --permanent
	sudo firewall-cmd --add-port=7946/udp --permanent
    sudo firewall-cmd --add-port=4789/tcp --permanent
	sudo firewall-cmd --reload
SCRIPT

Vagrant.configure(2) do |config|
  config.ssh.insert_key = false 
  config.vm.define "jenkins" do |jenkins|
    jenkins.vm.box = "shekeriev/centos-8-minimal"
    jenkins.vm.hostname = "jenkins.home.lab"
    jenkins.vm.network "private_network", ip: "192.168.99.100"
    jenkins.vm.network "forwarded_port", guest: 8080, host: 8090
	jenkins.vm.synced_folder "./vagrant/jenkins/master", "/vagrant", mount_options: ["dmode=755", "fmode=755"]
    jenkins.vm.provision "shell", inline: $configureMaster	
    end
   config.vm.define "slave" do |slave|
    slave.vm.box = "shekeriev/centos-8-minimal"
    slave.vm.hostname = "slave.home.lab"
    slave.vm.network "private_network", ip: "192.168.99.101"
    slave.vm.network "forwarded_port", guest: 80, host: 8888
	slave.vm.synced_folder "./vagrant/docker", "/vagrant", mount_options: ["dmode=755", "fmode=755"]
    slave.vm.provision "shell", inline: $configureSlave
    end
   config.vm.define "slave1" do |slave1|
    slave1.vm.box = "shekeriev/centos-8-minimal"
    slave1.vm.hostname = "slave1.home.lab"
    slave1.vm.network "private_network", ip: "192.168.99.102"
    slave1.vm.network "forwarded_port", guest: 3306, host: 3306
	slave1.vm.synced_folder "./vagrant/docker", "/vagrant", mount_options: ["dmode=755", "fmode=755"]
    slave1.vm.provision "shell", inline: $configureSlave1	
	end  
    config.vm.define "ansible" do |ansible|
    ansible.vm.box = "shekeriev/centos-8-minimal"
    ansible.vm.hostname = "ansible.home.lab"
    ansible.vm.network "private_network", ip: "192.168.99.103"
	ansible.vm.synced_folder "./vagrant/ansible", "/vagrant", mount_options: ["dmode=755", "fmode=755"]
    ansible.vm.provision "shell", inline: $configureAnsible	
	end
   end