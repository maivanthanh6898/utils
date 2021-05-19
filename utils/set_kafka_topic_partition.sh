#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$0")
topic=$1
shift

$BASEDIR/execute.sh kafka /home/kafka/bin/kafka-topics.sh --zookeeper localhost:2181 --topic $topic --alter --partitions $1
