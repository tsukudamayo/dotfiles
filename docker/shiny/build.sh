#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    xhost +localhost
    docker run -it --rm \
        -e PASSWORD=${PASSWORD} \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -p 3838:3838 \
        shiny-dev \
        /bin/bash
    xhost -localhost
else
    xhost +local:
    docker run -it --rm \
        -e PASSWORD=${PASSWORD} \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -p 3838:3838 \
        -e DISPLAY=$DISPLAY \
        shiny-dev \
        /bin/bash
    xhost -local:
fi
