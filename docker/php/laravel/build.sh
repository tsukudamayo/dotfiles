#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    xhost +localhost
    docker run -it --rm \
        -p 8000:8000 \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        php-dev \
        /bin/bash
    xhost -localhost
else
    xhost +local:
    docker run -it --rm \
        -p 8000:8000 \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e DISPLAY=$DISPLAY \
        php-dev \
        /bin/bash
    xhost -local:
fi
