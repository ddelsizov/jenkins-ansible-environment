#!/bin/bash
stop_container() {
  if [ "$(docker ps -aq -f status=running -f name=apache-web)" ]; then
      echo -ne "Stop "
      #docker stop $1
      docker kill apache-web
  fi

  if [ "$(docker ps -aq -f status=exited -f name=apache-web)" ]; then
      echo -ne "Remove "
      docker rm apache-web
  fi
}
stop_container

