#!/bin/bash

# This script checks if the microphone is currently in use.
# It outputs an icon if in use, or nothing if not.

# You can choose your icons here.
# Make sure your Waybar font supports these icons (e.g., Nerd Fonts).
MIC_IN_USE_ICON=""  # Example: Font Awesome microphone icon
MIC_NOT_IN_USE_ICON=" " # Example: Font Awesome microphone-slash icon (optional)

# Check for active source outputs (applications recording from the microphone)
if pactl list source-outputs | grep -q "Corked: no"; then
    echo "{\"text\":\"$MIC_IN_USE_ICON\", \"class\":\"mic-in-use\"}"
else
    # If you want to show an icon when not in use, uncomment the line below:
    # echo "{\"text\":\"$MIC_NOT_IN_USE_ICON\", \"class\":\"mic-not-in-use\"}"
    echo ""
fi
