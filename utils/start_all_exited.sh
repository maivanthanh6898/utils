docker ps -a --format "{{.ID}}:{{.Status}}" | grep Exit
echo "restarting..."
docker restart -t 0 $(docker ps -a --format "{{.ID}}:{{.Status}}" | grep Exit | cut -d ":" -f 1)
