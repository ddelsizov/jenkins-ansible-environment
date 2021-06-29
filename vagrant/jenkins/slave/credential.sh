#!/bin/bash
echo "** Sleep for 60 seconds until Jenkins is UP after restart"
sudo sleep 60
echo "** Execute create credential"
sudo cat /vagrant/jenkins/credential.xml | sudo java -jar /opt/jenkins-cli.jar -s http://localhost:8080 -auth ddelsizov:secretpassword create-credentials-by-xml "SystemCredentialsProvider::SystemContextResolver::jenkins" "(global)"
