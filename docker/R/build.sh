#!/bin/bash

xhost +localhost:
if [[ "$OSTYPE" == "darwin"* ]]; then
    docker run -it --rm \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        r-dev \
        /bin/bash
else
     docker run -it --rm \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e DISPLAY=$DISPLAY \
        r-dev \
        /bin/bash
fi
xhost -localhost:
