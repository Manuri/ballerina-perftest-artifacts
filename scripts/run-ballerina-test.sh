#!/bin/bash

bash ballerina-start.sh 1 data_service.bal

sh ../jmeter/preconfigured_jmeter/apache-jmeter-4.0/bin/jmeter -n -t ../ballerina/jmx/ballerina-warmup.jmx

#sh ../jmeter/preconfigured_jmeter/apache-jmeter-4.0/bin/jmeter -t ../ballerina/jmx/ballerina.jmx -n  -e -l ../results/ballerina/jtls/$1.jtl -o ../results/ballerina/reports/$1 -Jthreads=$1 -Jduration=1200

for var in 20 50 100 200 500 1000
do
sh ../jmeter/preconfigured_jmeter/apache-jmeter-4.0/bin/jmeter -t ../ballerina/jmx/ballerina.jmx -n  -e -l ../results/ballerina/jtls/$var.jtl -o ../results/ballerina/reports/$var -Jthreads=$var -Jduration=1200
bash db-clean.sh
done
