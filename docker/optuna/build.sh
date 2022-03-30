#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    xhost +localhost
    docker run -it --rm \
        -v $HOME:$HOME \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        --name optuna-dev \
        python310-dev \
        /bin/bash
    xhost -localhost
else
    xhost +local:
    docker run -it --rm \
        -v $HOME:$HOME \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e DISPLAY=$DISPLAY \
        --name optuna-dev \
        python310-dev \
        /bin/bash
    xhost -local:
fi
