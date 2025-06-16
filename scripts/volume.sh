#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute


device='default'    #audio device
interval='5'        #Percentage by which to update the volume
timeout='5'         #Notification timeout in seconds
bar_char="■"        #Character to use for the volume bar
padding="    "      #Space to pad out the bar at the left of the notification

# The dunstify timeout is in milliseconds, so multiply our seconds setting by 1000
notify_timeout=$((timeout*1000))

#Icon settings
#Base for all icons, or you can specify the full path to each
icon_base="/usr/share/icons/Papirus-Dark/16x16/panel/"
# Icon for when volume is changed
icon_audio_vol="$icon_base/audio-volume-high-panel.svg"
# Icon for when volume is muted
icon_audio_muted="$icon_base/audio-volume-muted.svg"


function get_volume {
    amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
    amixer get Master | grep off > /dev/null && amixer -q set Master unmute || amixer -q set Master mute
}

function send_notification {
    volume=$(get_volume)
    bar=$(seq -s "$bar_char" $(( (volume / 5)+1 )) | sed 's/[0-9]//g')
    spaces=$(seq -s " " $(( (20 - (volume / 5)+1) )) | sed 's/[0-9]//g')
    # Send the notification
    dunstify -a top-center -i "$icon_audio_vol" -t $notify_timeout -r 2593 -u normal "$bar$spaces $volume %"
}

case $1 in
    up)
        # Set the volume on (if it was muted)
        amixer -D "$device" set Master on > /dev/null
        # Up the volume (+ $interval%)
        amixer -D "$device" sset Master $interval%+ > /dev/null
        send_notification
	;;
    down)
        amixer -D "$device" set Master on > /dev/null
        amixer -D "$device" sset Master $interval%- > /dev/null
        send_notification
	;;
    mute)
    	# Toggle mute
        amixer -D "$device" set Master 1+ toggle > /dev/null
        if is_mute ; then
            dunstify -t $notify_timeout -i "$icon_audio_muted" -r 2593 -u normal "Mute"
        else
            send_notification
        fi
    ;;
	esac
