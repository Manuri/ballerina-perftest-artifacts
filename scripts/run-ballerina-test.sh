#!/bin/bash

#sh ../jmeter/preconfigured_jmeter/apache-jmeter-4.0/bin/jmeter -t ../ballerina/jmx/ballerina.jmx -n  -e -l ../results/ballerina/jtls/$1.jtl -o ../results/ballerina/reports/$1 -Jthreads=$1 -Jduration=1200

for var in 1 10 20 50 100 200 500 1000
do
	for jmxfile in SELECT SELECT-100 INSERT BATCHINSERT-100
	do
	bash ballerina-start.sh 1 data_service.bal
	sh ../jmeter/preconfigured_jmeter/apache-jmeter-4.0/bin/jmeter -n -t ../ballerina/jmx/ballerina-warmup.jmx
	sh ../jmeter/preconfigured_jmeter/apache-jmeter-4.0/bin/jmeter -t ../ballerina/jmx/ballerina-$jmxfile.jmx -n  -e -l ../results/ballerina/jtls/$jmxfile/$var.jtl -o ../results/ballerina/reports/$jmxfile/$var -Jthreads=$var -Jduration=1200
	bash db-clean.sh BALLERINA
	done
done
