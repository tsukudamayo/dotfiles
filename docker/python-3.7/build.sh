xhost +local:
docker run -it --rm \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=$DISPLAY \
    python-3.7 \
    /bin/bash

xhost -local:
