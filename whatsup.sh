#!/bin/bash

[ -z "$1" ] && echo "No argument supplied, please supply the name of your fuzzer" && exit 1

CONTAINER=$1
docker exec -it $CONTAINER afl-whatsup /fuzzing/syncdir
