#!/bin/bash

# Color scheme
source "$HOME/.config/sketchybar/colors.sh"

if [ "$SELECTED" = "true" ]; then
  sketchybar --set $NAME background.drawing=on \
                         background.color=$BLUE \
                         icon.color=$BG0
else
  sketchybar --set $NAME background.drawing=off \
                         icon.color=$WHITE
fi