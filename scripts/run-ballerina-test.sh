#!/bin/bash

sh ballerina-start.sh

sh ../jmeter/preconfigured_jmeter/apache-jmeter-4.0/bin/jmeter -t ../ballerina/jmx/ballerina-warmup.jmx

sh ../jmeter/preconfigured_jmeter/apache-jmeter-4.0/bin/jmeter -t ../ballerina/jmx/ballerina.jmx -n  -e -l ../results/ballerina/jtls/$1.jtl -o ../results/ballerina/reports/$1 -Jthreads=$1
