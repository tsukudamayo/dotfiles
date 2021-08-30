#!/bin/bash

echo ${github_username} 
echo ${PERSONAL_ACCESS_TOKEN}

docker-compose build \
--build-arg github_username=$1 \
--build-arg github_password=$2 \
--build-arg DB_USERNAME=boaters \
--build-arg DB_PASSWORD=$3 \
--build-arg DB_HOST=db \
--build-arg DB_TABLENAME=boatrace \
#--build-arg DB_INSTANCE_NAME= \
--no-cache

docker-compose up -d
