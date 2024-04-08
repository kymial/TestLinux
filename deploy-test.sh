#!/bin/bash

source ./var.sh

# set variables
JDK_PACKAGE_NAME="openjdk-11-jdk"
PROJECT_NAME="aws-v2"
PROJECT_VERSION="0.0.1"
GIT_USERNAME="NomadHuns"
SELETED_TIME_ZONE="Asia/Seoul"
GIT_URL="http://github.com/${GIT_USERNAME}/${PROJECT_NAME}.git"
JAR_PATH="${HOME}/${PROJECT_NAME}/build/libs/${PROJECT_NAME}-${PROJECT_VERSION}.jar"
echo "complete to set variables"

touch crontab_delete
crontab crontab_delete
rm crontab_delete
echo "delete to contab"

# TODO kill da project process
# need 2 check da project process b4 kill
if [ -n "${PROJECT_PID}" ]; then
	kill -9 ${PROJECT_PID}
	echo "killed project process"
fi


# update package manager
echo "try to update package manager list"
# sudo apt update
echo "comlete to update package manager list"

# TODO have to check to run the server already 
# and need to use if expression for first deploy

# install openjdk-11
if [ -z "$(dpkg -l | grep ${JDK_PACKAGE_NAME})" ]; then
   echo "${JDK_PACKAGE_NAME}is not installed"
   sudo apt install -y ${JDK_PACKAGE_NAME}
else
   echo "${JDK_PACKAGE_NAME} is already installed"
fi

# set timezone
sudo timedatectl set-timezone ${SELECTE_TIME_ZOME}
echo "${SELECTE_TIME_ZOME} : done to set timezone"

# delete folder
rm -rf ${HOME}/${PROJECT_NAME}
echo "complete to delete ${PROJECT_NAME} the project folder"

# git clone
echo "try to clone a spring boot project from github : url is ${GIT_URL}"
git clone ${GIT_URL}
echo "complete to clone the spring boot project"

# grant authority to gradlew
chmod u+x ${HOME}/${PROJECT_NAME}/gradlew
echo "done to grant authority to build files"

# build jar file
cd ${HOME}/aws-v2
echo "try to build files"
./gradlew clean build
echo "complete to build files"

# start spring boot server
echo "run to run server build file"
nohup java -jar ./build/libs/aws-v2-0.0.1.jar 1>${HOME}/log.out 2>${HOME}/err.out &

# TODO have to check server status constantly
echo "* * * * * ${HOME}/check-and-restart.sh" 1>>crontab_new
crontab crontab_new
rm crontab_new
echo "complete to register cron"


