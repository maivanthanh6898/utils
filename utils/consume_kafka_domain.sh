#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$0")
topic=$1
shift
domain=$1
shift
clientSSLProp="/home/kafka/$domain-client.ssl.properties"
echo "write this content to file. if file is existed. ignore this"
echo "**************************************************"
echo "echo \"security.protocol=SSL\" > $clientSSLProp"
echo "echo \"ssl.truststore.location=/home/kafka/keys/kafka/$domain/$domain.client.truststore.jks\" >> $clientSSLProp"
echo "echo \"ssl.truststore.password=aq1sw2de3fr4\" > $clientSSLProp"
echo "echo \"ssl.keystore.location=/home/kafka/keys/kafka/$domain/$domain.client.keystore.jks\" >> $clientSSLProp"
echo "echo \"ssl.keystore.password=aq1sw2de3fr4\" >> $clientSSLProp"
echo "echo \"ssl.key.password=aq1sw2de3fr4\" >> $clientSSLProp"
echo "**************************************************"
echo "then run"
echo "/home/kafka/bin/kafka-console-consumer.sh --bootstrap-server $1 --topic $topic --consumer.config $clientSSLProp $@"

$BASEDIR/execute.sh kafka bash
#$BASEDIR/execute.sh kafka /home/kafka/bin/kafka-console-consumer.sh --bootstrap-server $1 --topic $topic --consumer.config $clientSSLProp $@
