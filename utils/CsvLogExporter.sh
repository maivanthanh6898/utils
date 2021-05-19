#!/usr/bin/env bash
printf "Date,Url,Query Time,Status,API\n" >> /home/read/apiQuery.csv
cat containers/logs/fss-rest-bridge-prod/application.log.* | grep "(\[[0-9T\-\:\.]+.*finish exchange token [0-9A-Za-z]+ took.*seconds\
 [0-9]+|\[[0-9T\-\:\.]+.*send.*took.*seconds [0-9]+|\[[0-9T\-\:\.]+.*execute refresh token.*took.*seconds [0-9]+)" -Eoh | while read -r line ; do
	if [[ $line != *"send low latency message"* ]]; then
	time=${line:1:23}
	link=$(echo $line | grep "(https://[a-zA-Z0-9./?=%&]+)|exchange token|refresh token)" -Eoh)
	url=${link//%2F/\/}
	queryTime=$(echo $line | grep "[0-9.]+ seconds" -Eoh)
	took=${queryTime//seconds/}
	status=$(echo "${line: -3}")
	linkAPi=$(echo $url | grep "(\/[a-z]+\/[a-zA-Z]+(\/[FDS0-9]+)?(\/[a-zA-Z]+)?|\/accounts)" -Eoh)
	if [ -z $linkAPi ]; then 
		linkAPi="/oauth/token" 
	fi
	api=$(echo $linkAPi | perl -pe 's/(FDS)?[0-9]+/\{accountId\}/g')
	printf "$time,$url,$took,$status,$api\n" >> /home/read/apiQuery.csv
	fi
done

