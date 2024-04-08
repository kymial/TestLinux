#!/bin/bash

source ./var.sh

if [ -z "${PROJECT_PID}" ]; then
	nohup java -jar ${JAR_PATH} 1>${HOME}/log.out 2>${HOME}/err.out &
else
	echo "its running!"
fi
