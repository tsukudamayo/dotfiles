#!/bin/bash

echo ${github_username} 
echo ${PERSONAL_ACCESS_TOKEN}

echo $1
echo $2
echo $3

docker-compose build \
--build-arg github_username=$1 \
--build-arg github_password=$2 \
--build-arg DB_USERNAME=local_test_user \
--build-arg DB_PASSWORD=$3 \
--build-arg DB_HOST=db \
--build-arg DB_TABLENAME=boatrace \
--no-cache
#--build-arg DB_INSTANCE_NAME= \
#--build-arg DB_USERNAME=boaters \

docker-compose up -d
