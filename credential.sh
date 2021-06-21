#!/bin/bash
sudo cat /vagrant/credential.xml | sudo java -jar /opt/jenkins-cli.jar -s http://localhost:8080 -auth ddelsizov:secretpassword create-credentials-by-xml "SystemCredentialsProvider::SystemContextResolver::jenkins" "(global)"
