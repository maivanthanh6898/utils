#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$0")
echo "script base dir: $BASEDIR"

currentIdFile="$BASEDIR/current_id";

filter="$1"
container=""
if [ "$filter" = "" ] || [ ${#filter} -eq 1 ]; then
    echo "get current default id"
    if [ -f "$currentIdFile" ]; then
        container=$(cat $currentIdFile)
    else
        echo "there is no current id file. Exit"
        unset dockerId
        exit 1
    fi
else
    echo "start searching with keyword $filter"
    docker ps -a | grep $filter
    number=$(docker ps -a | grep $filter | wc -l)
    if [ "$number" != "1" ]; then
        echo "should only one matched. Exit"
        unset dockerId
        exit 1
    fi
    container=$(docker ps -a | grep $filter | cut -d " " -f 1)
fi
export dockerId=$container
echo $dockerId
echo $dockerId > $currentIdFile
