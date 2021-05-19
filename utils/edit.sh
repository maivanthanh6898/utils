#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$0")
echo "script base dir: $BASEDIR"

. ./$BASEDIR/id.sh $1
echo $dockerId

tmpDir="$BASEDIR/tmp"
filename="to_edit$(date +%s).tmp"
mkdir -p $tmpDir
fileToEdit="$2"
echo "copy file"
echo "docker cp $dockerId:$fileToEdit $tmpDir/$filename"
docker cp $dockerId:$2 $tmpDir/$filename
echo "edit"
vi "$tmpDir/$filename"
echo "finish editing. Copy back"
echo "docker cp $tmpDir/$filename $dockerId:$fileToEdit"
docker cp $tmpDir/$filename $dockerId:$fileToEdit
echo "clear file"
rm -f $tmpDir/$filename
if [ "$3" = "-r" ]; then
    echo "restarting"
    docker restart -t 0 $dockerId
fi
