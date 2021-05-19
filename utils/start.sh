#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$0")
echo "script base dir: $BASEDIR"

. ./$BASEDIR/id.sh $1
echo $dockerId

docker start $dockerId
echo "finish"
docker ps -a | grep $dockerId
