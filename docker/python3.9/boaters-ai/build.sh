#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    xhost +localhost
    docker exec -it $(docker ps | grep boaters-ai_crawler | awk '{print $1}') \
        /bin/bash
    xhost -localhost
else
    xhost +local:
    docker exec -it $(docker ps | grep boaters-ai_crawler | awk '{print $1}') \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e DISPLAY=$DISPLAY \
        /bin/bash
    xhost -local:
fi
