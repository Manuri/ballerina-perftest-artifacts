#!/bin/bash

sh ei-start.sh

sh ../jmeter/preconfigured_jmeter/apache-jmeter-4.0/bin/jmeter -t ../ei/jmx/DSS-warmup.jmx

sh ../jmeter/preconfigured_jmeter/apache-jmeter-4.0/bin/jmeter -t ../ei/jmx/DSS.jmx -n  -e -l ../results/ei/jtls/$1.jtl -o ../results/ei/reports/$1 -Jthreads=$1
