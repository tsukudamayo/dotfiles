#!/bin/bash

xhost +local:
if [[ "$OSTYPE" == "darwin"* ]]; then
    docker run -it --rm \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        python3.7 \
        /bin/bash
else
     docker run -it --rm \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e DISPLAY=$DISPLAY \
        python3.7 \
        /bin/bash
fi
xhost -local:
