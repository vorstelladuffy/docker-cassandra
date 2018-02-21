#!/bin/bash

DATE="date +%T"
function curl_a_bunch {
	local url=$1
	local delay=$2
	local max=$3
	local total=0

	while [[ -z "${max}" ]] || [[ $total -lt $max ]]
	do
		echo "`$DATE` curl" >> $TEST_LOG
		2>&1 curl -s $url >> /dev/null 
		[[ -z "${delay}" ]] || sleep $delay
		total=$((total + delay))
	done
}

export CAS_LOG=/logs/cassandra.out
export TEST_LOG=/logs/test.out
START_STRING="-------------------------------\nTEST STARTED: `$DATE`\n-------------------------------"

echo -e "${START_STRING}" >> $CAS_LOG
echo -e "${START_STRING}" >> $TEST_LOG

echo "running as `whoami`" >> $TEST_LOG
echo "ENVIRONMENT [" >> $TEST_LOG
env >> $TEST_LOG
echo "]" >> $TEST_LOG

sar -u 1 >> $TEST_LOG &
cassandra -f >> $CAS_LOG &

echo "`$DATE` sleep 30" >> $TEST_LOG
sleep 30

echo "`$DATE` curl every 20 seconds for 3 minutes" >> $TEST_LOG
curl_a_bunch http://localhost:1234 20 180

echo "`$DATE` hammer endpoint" >> $TEST_LOG
curl_a_bunch http://localhost:1234