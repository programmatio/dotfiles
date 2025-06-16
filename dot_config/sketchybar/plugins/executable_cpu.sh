#!/bin/bash

# Get CPU usage percentage
CPU_USAGE=$(ps -A -o %cpu | awk '{s+=$1} END {print s}')
CPU_PERCENT=$(printf "%.0f" $CPU_USAGE)

# Color based on CPU usage
if [[ $CPU_PERCENT -gt 80 ]]; then
  COLOR=0xfff7768e  # Red
elif [[ $CPU_PERCENT -gt 60 ]]; then
  COLOR=0xffe0af68  # Yellow
else
  COLOR=0xff9ece6a  # Green
fi

sketchybar --set $NAME label="${CPU_PERCENT}%" label.color=$COLOR