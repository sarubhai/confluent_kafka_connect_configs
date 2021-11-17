#!/bin/bash
# Name: bulkUploadKafkaConnectConfigs.sh
# Owner: Saurav Mitra
# Description: Import All Kafka Connect Configs

cd json-configs
# files=`ls`
# files=`find . -type f -iname '*.json' | sed 's|^./||' | sort`

# MacOS Array issue
IFS=$'\n'
files=($(find . -name '*.json' | sed 's|^./||' | sort))
unset IFS
# echo ${#files[@]}

for file in "${files[@]}"
do
    cname=`cat ${file} | jq -r '.name'`
    # echo "${file} --> ${cname}"
    curl -k -s -X PUT -H "Content-Type: application/json" -d @${file} https://10.0.1.40:8083/connectors/${cname}/config | jq .
    sleep 10;
done

# cname='src-orcl-jdbc-bulk-employees'
# file='1a_src-orcl-jdbc-bulk-employees.json'
# curl -k -s -X PUT -H "Content-Type: application/json" -d @${file} https://10.0.1.40:8083/connectors/${cname}/config | jq .
