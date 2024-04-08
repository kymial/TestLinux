#!/bin/bash

export JDK_PACKAGE_NAME="openjdk-11-jdk"
export PROJECT_NAME="aws-v2"
export PROJECT_VERSION="0.0.1"
export GIT_USERNAME="NomadHuns"
export SELETED_TIME_ZONE="Asia/Seoul"
export GIT_URL="http://github.com/${GIT_USERNAME}/${PROJECT_NAME}.git"
export JAR_PATH="${HOME}/${PROJECT_NAME}/build/libs/${PROJECT_NAME}-${PROJECT_VERSION}.jar"
export PROJECT_PID="$(pgrep -f ${PROJECT_NAME}-${PROJECT_VERSION}.jar)"
