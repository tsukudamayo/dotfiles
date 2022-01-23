#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    xhost +localhost
    docker run -it --rm \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v /tmp/what-should-i-eat/:/workspace/ \
        --name python39-dev \
        python39-dev \
        /bin/bash
    xhost -localhost
else
    xhost +local:
    docker run -it --rm \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v /tmp/what-should-i-eat/:/workspace/ \
        -e DISPLAY=$DISPLAY \
        --name python39-dev \
        python39-dev \
        /bin/bash
    xhost -local:
fi
