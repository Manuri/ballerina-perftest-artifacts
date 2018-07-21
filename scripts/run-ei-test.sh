#!/bin/bash

for var in 1 10 20 50 100 200 500 1000
do
	for jmxfile in SELECT SELECT-100 INSERT BATCHINSERT-100
	do
	bash ei-start.sh
	sh ../jmeter/preconfigured_jmeter/apache-jmeter-4.0/bin/jmeter -n -t ../ei/jmx/EI-warmup.jmx
	sh ../jmeter/preconfigured_jmeter/apache-jmeter-4.0/bin/jmeter -t ../ei/jmx/EI-$jmxfile.jmx -n  -e -l ../results/ei/jtls/$jmxfile/$var.jtl -o ../results/ei/reports/$jmxfile/$var -Jthreads=$var -Jduration=1200
	bash db-clean.sh EI
	done
done
