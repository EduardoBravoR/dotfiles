#!/bin/bash

# Detectar si /dev/video0 está en uso
if fuser /dev/video0 > /dev/null 2>&1; then
    echo '{"text": "", "class": "camera-on"}'
else
    echo '{"text": "", "class": "camera-off"}'
fi
