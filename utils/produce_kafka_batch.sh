#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$0")
topic=$1
shift

file="$1"
shift

homeDir="/home/kafka"
$BASEDIR/copy.sh kafka -i $file $file
$BASEDIR/execute.sh kafka "$homeDir/bin/kafka-console-producer.sh" --broker-list localhost:9092 --topic $topic < $file
$BASEDIR/execute.sh kafka rm $file
