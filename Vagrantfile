# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
    
  config.ssh.insert_key = false
  
  config.vm.define "slave" do |slave|
    slave.vm.box = "shekeriev/centos-8-minimal"
    slave.vm.hostname = "slave.home.lab"
    slave.vm.network "private_network", ip: "192.168.99.101"
    slave.vm.network "forwarded_port", guest: 80, host: 8888
	slave.vm.provision "shell", path: "slaveconf.sh"
  end

  config.vm.define "jenkins" do |jenkins|
    jenkins.vm.box = "shekeriev/centos-8-minimal"
    jenkins.vm.hostname = "jenkins.home.lab"
    jenkins.vm.network "private_network", ip: "192.168.99.100"
    jenkins.vm.network "forwarded_port", guest: 8080, host: 8090
	jenkins.vm.synced_folder ".", "/vagrant", mount_options: ["dmode=755", "fmode=755"]	
	jenkins.vm.provision "shell", inline: <<EOS
echo "192.168.99.100 jenkins.home.lab jenkins" >> /etc/hosts
echo "192.168.99.101 slave.home.lab slave" >> /etc/hosts
sudo firewall-cmd --add-port=8080/tcp --permanent
sudo firewall-cmd --reload
sudo useradd jenkins
sudo echo "jenkins:secretpassword" | sudo chpasswd
sudo echo 'jenkins ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
sudo usermod -s /bin/bash jenkins
sudo echo "jenkins:secretpassword" | sudo chpasswd
EOS
    jenkins.vm.provision "ansible_local" do |ansible|
    ansible.become = true
    ansible.install_mode = :default
	ansible.limit = "all"
	ansible.galaxy_command = "sudo ansible-galaxy install --role-file=%{role_file} --roles-path=%{roles_path} --force"
    ansible.galaxy_role_file = "requirements.yml"
    ansible.galaxy_roles_path = "/etc/ansible/roles"
	ansible.inventory_path = "inventory"
	ansible.playbook = "playbook.yml"
  end
 end
end