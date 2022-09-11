#!/bin/bash

DIRNAME="$(dirname "$0")"
PORTAL_DIR="$(realpath "$DIRNAME")"/../Portal

if [ "$1" == "--pulse" ]
then

pactl load-module module-native-protocol-unix socket=/tmp/pulseaudio.socket

cat << EOF > /tmp/pulseaudio.client.conf
default-server = unix:/tmp/pulseaudio.socket
# Prevent a server running in the container
autospawn = no
daemon-binary = /bin/true
# Prevent the use of shared memory
enable-shm = false
EOF

nvidia-docker run -ti --rm -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PORTAL_DIR:/usr/local/games/Portal" -e DISPLAY=unix:0\
    --env PULSE_SERVER=unix:/tmp/pulseaudio.socket --env PULSE_COOKIE=/tmp/pulseaudio.cookie \
    --volume /tmp/pulseaudio.socket:/tmp/pulseaudio.socket --volume /tmp/pulseaudio.client.conf:/etc/pulse/client.conf\
    --name portal damian/portal:1.0

else

exec nvidia-docker run -ti --rm -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PORTAL_DIR:/usr/local/games/Portal" -e DISPLAY=unix:0\
    --device /dev/snd --name portal damian/portal:1.0

fi
