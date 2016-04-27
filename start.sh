#!/bin/bash

[ -z "$1" ] && echo "No argument supplied, please supply a name for your fuzzer" && exit 1

CONTAINER=$1

RUNNING=$(docker inspect --format="{{ .State.Running }}" $CONTAINER 2> /dev/null)

if [ $? -eq 1 ]; then
  echo "$CONTAINER does not exist, creating now"
  docker run --name $CONTAINER -d qkyrie/afl-openssl
else
  if [ "$RUNNING" == "false" ]; then
    echo "$CONTAINER exists but is not running, restarting now"
    docker start $CONTAINER
  else
    echo "$CONTAINER is already running."
  fi
fi
