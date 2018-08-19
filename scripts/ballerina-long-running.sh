#!/bin/bash

bash ballerina-start.sh
#sh ../jmeter/preconfigured_jmeter/apache-jmeter-4.0/bin/jmeter -t ../ballerina/jmx/ballerina-SELECT.jmx -n -Jthreads=100 -Jduration=43200
sh ../jmeter/preconfigured_jmeter/apache-jmeter-4.0/bin/jmeter -t ../ballerina/jmx/ballerina-INSERT.jmx -n -Jthreads=100 -Jduration=43200
