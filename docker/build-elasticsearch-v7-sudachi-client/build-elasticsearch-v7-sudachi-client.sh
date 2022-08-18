#!/bin/bash

export DOCKER_BUILDKIT=1
docker build -t elasticsearch-v7-sudachi-client -f ./sample/elasticsearch-sample/elasticsearch-v7-sudachi/client/dev.Dockerfile ./sample/elasticsearch-sample/elasticsearch-v7-sudachi/client/

if [[ "$OSTYPE" == "darwin"* ]]; then
    xhost +$(multipass list | grep docker-vm | awk '{print $3}')
    docker run -it --rm \
        -v $(pwd)/sample/elasticsearch-sample/elasticsearch-v7-sudachi/client/:/workspace \
	-v /tmp:/tmp \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e DISPLAY=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}'):0.0 \
        --name elasticsearch-v7-sudachi-client \
        elasticsearch-v7-sudachi-client \
        /bin/bash
    xhost -$(multipass list | grep docker-vm | awk '{print $3}')
else
    xhost +local:
    docker run -it --rm \
	-v $(pwd)/sample/elasticsearch-sample/elasticsearch-v7-sudachi/client/:/workspace \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e DISPLAY=$DISPLAY \
        --name elasticsearch-v7-sudachi-client \
        elasticsearch-v7-sudachi-client \
        /bin/bash
    xhost -local:
fi
