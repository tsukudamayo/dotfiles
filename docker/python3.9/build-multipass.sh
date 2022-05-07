#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    xhost +$(multipass list | grep docker-vm | awk '{print $3}')
    docker run -it --rm \
        -v $HOME:$HOME \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e DISPLAY=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}'):0.0 \
        --name python39-dev \
        python39-dev \
        /bin/bash
    xhost -$(multipass list | grep docker-vm | awk '{print $3}')

else
    xhost +local:
    docker run -it --rm \
        -v $HOME:$HOME \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e DISPLAY=$DISPLAY \
        --name python39-dev \
        python39-dev \
        /bin/bash
    xhost -local:
fi
