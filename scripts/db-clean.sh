#!/bin/bash

batch_insert_count=$(mysql -DBALLERINA -u root -p123 -se "SELECT COUNT(*) FROM batchinserttest")
insert_count=$(mysql -DBALLERINA -u root -p123 -se "SELECT COUNT(*) FROM inserttest")
echo $batch_insert_count >> counts.txt
echo $insert_count >> counts.txt
echo '====' >> counts.txt
mysql -u root -p123 < db-clean.sql
