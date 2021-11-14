#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    xhost +localhost
    docker run -it --rm \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -p 3000:3000 \
        --name next-dev \
        next-dev \
        /bin/bash
    xhost -localhost
else
    xhost +local:
    docker run -it --rm \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -p 3000:3000 \
        -e DISPLAY=$DISPLAY \
        --name next-dev \
        next-dev \
        /bin/bash
    xhost -local:
fi
