#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$0")
echo "script base dir: $BASEDIR"

. ./$BASEDIR/id.sh $1
echo $dockerId

read -p "Are you sure to remove this container '$dockerId'? [Y/n]" response
response=${response,,} # tolower

if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
    docker stop $dockerId -t 0
    docker rm $dockerId
fi

echo "finish"
docker ps -a | grep $dockerId
