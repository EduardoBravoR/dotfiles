#!/usr/bin/env bash

# You can call this script like this:
# $ ./brightnessControl.sh up
# $ ./brightnessControl.sh down

# Script inspired by these wonderful people:
# https://github.com/dastorm/volume-notification-dunst/blob/master/volume.sh
# https://gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a

timeout='5'         #Notification timeout in seconds
notify_timeout=$((timeout*1000))

function get_brightness {
  xbacklight -get | cut -d '.' -f 1
}

function send_notification {
  icon="/usr/share/icons/Papirus-Dark/16x16/actions/brightnesssettings.svg"
  brightness=$(get_brightness)
  # Make the bar with the special character ─ (it's not dash -)
  # https://en.wikipedia.org/wiki/Box-drawing_character
  bar=$(seq -s "■" $(( (brightness / 5)+1 )) | sed 's/[0-9]//g')
  spaces=$(seq -s " " $((20 - (brightness / 5)+1 )) | sed 's/[0-9]//g')
  # Send the notification
  dunstify -a top-center -i "$icon" -t $notify_timeout -r 5555 -u normal "$bar$spaces $brightness %"
}

case $1 in
  up)
    # increase the backlight by 5%
    xbacklight -inc 10
    send_notification
    ;;
  down)
    # decrease the backlight by 5%
    xbacklight -dec 10
    send_notification
    ;;
esac
