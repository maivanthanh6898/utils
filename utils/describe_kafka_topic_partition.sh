#!/usr/bin/env bash
set -e

BASEDIR=$(dirname "$0")
topic=$1
shift

cd $cdir
$BASEDIR/execute.sh kafka /home/kafka/bin/kafka-run-class.sh kafka.tools.GetOffsetShell -broker-list localhost:9092 --topic $topic $@
