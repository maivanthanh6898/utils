#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$0")
topic=$1
shift

homeDir="/home/kafka"
if [ "$1" = "" ]; then
    $BASEDIR/execute.sh kafka "$homeDir/bin/kafka-console-producer.sh" --broker-list localhost:9092 --topic $topic
else
    echo "$1" | $BASEDIR/execute.sh kafka "$homeDir/bin/kafka-console-producer.sh" --broker-list localhost:9092 --topic $topic
fi
