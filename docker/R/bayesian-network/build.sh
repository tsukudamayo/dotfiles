#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    xhost +localhost
    docker run -it --rm \
        -e PASSWORD=${PASSWORD} \
        -p 3838:3838 \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v $(pwd):/workspace/data \
        kmedu-data-analysis-r \
        /bin/bash
    xhost -localhost
else
    xhost +local:
    docker run -it --rm \
        -e PASSWORD=${PASSWORD} \
        -p 3838:3838 \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v $(pwd):/workspace/data \
        -e DISPLAY=$DISPLAY \
        kmedu-data-analysis-r \
        /bin/bash
    xhost -local:
fi
