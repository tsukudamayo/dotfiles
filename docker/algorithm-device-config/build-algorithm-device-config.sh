#!/bin/bash

export DOCKER_BUILDKIT=1
docker build -t algorithm-device-config -f ./algorithm-device-config/dev.Dockerfile ./algorithm-device-config

if [[ "$OSTYPE" == "darwin"* ]]; then
    xhost +$(multipass list | grep docker-vm | awk '{print $3}')
    docker run -it --rm \
        -v $(pwd)/algorithm-device-config:/workspace \
	-v /tmp:/tmp \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e DISPLAY=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}'):0.0 \
        --name algorithm-device-config \
        algorithm-device-config \
        /bin/bash
    xhost -$(multipass list | grep docker-vm | awk '{print $3}')
else
    xhost +local:
    docker run -it --rm \
	-v $(pwd)/algorithm-device-config/:/workspace \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e DISPLAY=$DISPLAY \
        --name algorithm-device-config \
        algorithm-device-config \
        /bin/bash
    xhost -local:
fi
