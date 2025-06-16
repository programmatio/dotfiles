#!/bin/bash

# Only run on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
  exit 0
fi

# Get battery info
BATTERY_INFO=$(pmset -g batt 2>/dev/null)
if [ -z "$BATTERY_INFO" ]; then
  sketchybar --set $NAME drawing=off
  exit 0
fi

BATTERY_PERCENT=$(echo $BATTERY_INFO | grep -o '[0-9]\+%' | cut -d% -f1)
CHARGING=$(echo $BATTERY_INFO | grep 'AC Power')

# Set icon based on battery level and charging status
if [[ $CHARGING != "" ]]; then
  ICON=""
elif [[ $BATTERY_PERCENT -gt 80 ]]; then
  ICON=""
elif [[ $BATTERY_PERCENT -gt 60 ]]; then
  ICON=""
elif [[ $BATTERY_PERCENT -gt 40 ]]; then
  ICON=""
elif [[ $BATTERY_PERCENT -gt 20 ]]; then
  ICON=""
else
  ICON=""
fi

# Color based on battery level
if [[ $BATTERY_PERCENT -lt 20 ]]; then
  COLOR=0xfff7768e  # Red
elif [[ $BATTERY_PERCENT -lt 50 ]]; then
  COLOR=0xffe0af68  # Yellow
else
  COLOR=0xff9ece6a  # Green
fi

sketchybar --set $NAME icon="$ICON" label="${BATTERY_PERCENT}%" icon.color=$COLOR label.color=$COLOR