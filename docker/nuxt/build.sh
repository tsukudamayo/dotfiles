#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    xhost +localhost
    docker run -it --rm \
        -p 3000:3000 \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        nuxt-dev \
        /bin/bash
    xhost -localhost
else
    xhost +local:
    docker run -it --rm \
        -p 3000:3000 \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e DISPLAY=$DISPLAY \
        nuxt-dev \
        /bin/bash
    xhost -local:
fi
