#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$0")
topic=$1
shift

$BASEDIR/execute.sh kafka /home/kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic $topic $@
