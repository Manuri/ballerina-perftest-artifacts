#!/bin/bash

bash run-ballerina-test.sh

if pgrep -f ballerina/bre > /dev/null; then
    echo "Shutting down Ballerina"
    pkill -f ballerina/bre
fi

bash run-ei-test.sh

