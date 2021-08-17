#!/bin/bash

echo ${github_username}
echo ${PERSONAL_ACCESS_TOKEN}
docker-compose build --build-arg github_username=${github_username} --build-arg github_password=${PERSONAL_ACCESS_TOKEN}
docker-compose up -d
