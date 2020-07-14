#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    xhost +localhost
    docker run -it --rm \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        python3.8 \
        /bin/bash
    xhost -localhost
else
    xhost +local:
    docker run -it --rm \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e DISPLAY=$DISPLAY \
        python3.8 \
        /bin/bash
    xhost -local:
fi
