#!/bin/bash
caps=$(cat /sys/class/leds/*capslock/brightness 2>/dev/null | head -n 1)
if [[ "$caps" == "1" ]]; then
    echo '{"text":" A", "tooltip":"Caps Lock on"}'
else
    echo '{"text":"", "tooltip":"Caps Lock disabled"}'
fi
