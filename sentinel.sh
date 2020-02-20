#!/usr/bin/env bash
GOOD_RESPONSE="HTTP/1.1 200 OK\r\nConnection: keep-alive\r\n\r\n${2:-"OK"}\r\n"
BAD_RESPONSE="HTTP/1.1 404 Not Found: url does not exist\r\nConnection: keep-alive\r\n\r\n${2:-"OK"}\r\n"

while 	{ 
	check=GOOD

	for i in $(echo $TARGET_HOSTS | sed "s/,/ /g")
 	do 
		#echo health=`curl -s -o /dev/null -I -w "%{http_code}" $i`
		health=`curl -s -o /dev/null -I -w "%{http_code}" $i`
		#echo "health = $health"
		if [ "$health" != "200" ]; then
			check=BAD
		fi
	done

	if [ "$check" == "GOOD" ]; then
		echo -en "$GOOD_RESPONSE"
	else
		echo -en "$BAD_RESPONSE"
	fi

	#health=`curl -s -o /dev/null -I -w "%{http_code}" https://headerprinter.homelab.fynesy.com`
	#if [ "$health" == "200" ]; then
		#echo -en "$GOOD_RESPONSE" 
	#else
		#echo -en "$BAD_RESPONSE"
	#fi



	} | nc -l "${1:-8080}" ; do
  echo "================================================"
done
