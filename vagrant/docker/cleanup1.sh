#!/bin/bash
echo "Clean up containers"
stop_container() {
  if [ "$(docker container ps -al -f status=running -f name=mysql-1)" ]; then
      echo -ne "Kill mysql-1 "
      #docker stop $1
      docker kill mysql-1
      docker rm mysql-1
  fi

  if [ "$(docker ps -aq -f status=exited -f name=mysql-1)" ]; then
      echo -ne "Remove "
      docker rm mysql-1
  fi
}
stop_container

