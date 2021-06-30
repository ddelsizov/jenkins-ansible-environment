#!/bin/bash
echo "Clean up containers"
stop_container() {
  if [ "$(docker ps -aq -f status=running -f name=php-1)" ]; then
      echo -ne "Kill apache-web "
      #docker stop $1
      docker kill php-1
	  docker rm php-1
  fi

  if [ "$(docker ps -aq -f status=exited -f name=php-1)" ]; then
      echo -ne "Remove "
      docker rm php-1
  fi
}
stop_container

