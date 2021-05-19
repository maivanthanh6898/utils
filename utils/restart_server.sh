BASEDIR=$(dirname "$0")
echo "script base dir: $BASEDIR"
echo "show all services"
docker ps -a
echo "stop all service"
docker stop -t 0 $(docker ps -a --format "{{.ID}}")
echo "setting not exit if getting error"
set -e

restart_service() {
  service="$1"
  echo "try to restart service $service"
  . ./$BASEDIR/id.sh $service
  if [ "$dockerId" = "" ]; then
    echo "not found service"
  else
    echo $dockerId
    echo "restarting $service"
    docker restart -t 0 $dockerId
    echo "try to sleep abit"
    if [ "kafka" = $service ]; then
      sleep 10
    else
      sleep 3
    fi
  fi
}
restart_service "kafka"
restart_service "mysql"
restart_service "redis"
restart_service "mongo"
restart_service "domain-connector"
echo "sleep abit more for the rest..."
sleep 10
echo "restart the rest which is still exited"
./$BASEDIR/start_all_exited.sh
