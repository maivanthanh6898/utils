#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$0")
echo "script base dir: $BASEDIR"

. ./$BASEDIR/id.sh $1
echo $dockerId

shift


currentDockerDir=$(docker exec $dockerId pwd)
echo "current dir on docker = $currentDockerDir"
if [ "$1" = "-i" ]; then
    read -p "Are you sure to copy $2 to $currentDockerDir/$3? [Y/n]" response
    response=${response,,} # tolower
    if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
        echo "copying..."
        docker cp  $2 $dockerId:$currentDockerDir/$3
        docker exec $dockerId ls -l $currentDockerDir/$3
    fi
else
    read -p "Are you sure to copy $currentDockerDir/$2 to $3? [Y/n]" response
    response=${response,,} # tolower
    if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
        echo "copying..."
        docker cp $dockerId:$currentDockerDir/$2 $3
        docker exec $dockerId ls -l $currentDockerDir/$2
    fi
fi
