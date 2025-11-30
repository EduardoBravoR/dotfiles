#!/bin/bash
CAPTURE_DIR="$HOME/Pictures"
mkdir -p "$CAPTURE_DIR"
FILENAME="screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"
FILEPATH="$CAPTURE_DIR/$FILENAME"

MODE=$1

case $MODE in
    region)
        grim -g "$(slurp)" "$FILEPATH"
        NOTIFY_MSG="Region screenshoot saved"
        DETAIL_MSG="File saved as: $FILENAME"
        ;;
    monitor)
        grim -o "$(hyprctl -j monitors | jq -r '.[] | select(.focused).name')" "$FILEPATH"
        NOTIFY_MSG="Monitor screenshoot saved"
        DETAIL_MSG="File saved as: $FILENAME"
        ;;
    window)
        grim -g "$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" "$FILEPATH"
        NOTIFY_MSG="Window screenshoot saved"
        DETAIL_MSG="File saved as: $FILENAME"
        ;;
    *)
        NOTIFY_MSG="Error"
        DETAIL_MSG="Error taking screenshoot"
        exit 1
        ;;
esac

notify-send "$NOTIFY_MSG" "$DETAIL_MSG" -i "$FILEPATH"
