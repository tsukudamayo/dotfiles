#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    xhost +localhost
    docker run -it --rm \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -p 18000:18000 \
        --name zenn-dev \
        zenn-dev \
        /bin/bash
    xhost -localhost
else
    xhost +local:
    docker run -it --rm \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -p 18000:18000 \
        -e DISPLAY=$DISPLAY \
        --name zenn-dev \
        zenn-dev \
        /bin/bash
    xhost -local:
fi
