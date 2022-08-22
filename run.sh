#!/bin/bash

DIRNAME="$(dirname "$0")"
PORTAL_DIR="$(realpath "$DIRNAME")"/../Portal

exec nvidia-docker run -ti --rm -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PORTAL_DIR:/usr/local/games/Portal" -e DISPLAY=unix:0 --device /dev/snd --name portal damian/portal:1.0
