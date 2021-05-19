#!/usr/bin/env bash
for i in $(docker ps --format '{{.ID}}:{{.Image}}')
do
        dockerId=$(echo $i | cut -d ':' -f 1)
        echo "docker exec -t $dockerId $1"
        echo $i
        data=$(docker exec -t $dockerId $1)
        if [ ! -z "$2" ]; then
        data=$(grep "$2" <<< $data)
  fi
        echo "$data"
done
