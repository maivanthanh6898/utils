#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$0")
echo "script base dir: $BASEDIR"

. ./$BASEDIR/id.sh $1
echo $dockerId

docker restart $dockerId -t 0
echo "finish restart. show log..."
