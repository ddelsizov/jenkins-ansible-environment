#!/bin/bash
cmdstop(){
docker stop "$(docker ps -a -q)"
}
cmdremove(){
docker rm "$(docker ps -a -q)"
}
cmdstop
cmdremove
echo rm -rf /opt/jenkins/projects/*
