#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$0")
echo "script base dir: $BASEDIR"

. ./$BASEDIR/id.sh $1
echo $dockerId
shift
echo "docker exec -ti $dockerId $@"
docker exec -ti $container $@

