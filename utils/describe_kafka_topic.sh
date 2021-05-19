#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$0")
topic=$1
shift

cdir=$(pwd)
cd /home/ubuntu/containers/share
. ./app_env.sh

cd $cdir
$BASEDIR/execute.sh kafka /home/kafka/bin/kafka-topics.sh --zookeeper localhost:2181 --topic $topic --describe
