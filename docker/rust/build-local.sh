#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    xhost +localhost
    docker run -it --rm \
        -v $HOME:$HOME \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e USER=$USER \
        --name rust-dev \
        rust-dev \
        /bin/bash
    xhost -localhost
else
    xhost +local:
    docker run -it --rm \
        -v $HOME:$HOME \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e USER=$USER \
        -e DISPLAY=$DISPLAY \
        --name rust-dev \
        rust-dev \
        /bin/bash
    xhost -local:
fi

# docker run -it --rm -e USER=$USER rust-dev /bin/bash
# XXX
# emacs -nw --user ''
