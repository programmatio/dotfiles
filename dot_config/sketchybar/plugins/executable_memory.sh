#!/bin/bash

# Get memory usage
MEMORY_USAGE=$(memory_pressure | grep 'System-wide memory free percentage' | awk '{print 100-$5}')
MEMORY_PERCENT=$(printf "%.0f" $MEMORY_USAGE)

# Color based on memory usage
if [[ $MEMORY_PERCENT -gt 80 ]]; then
  COLOR=0xfff7768e  # Red
elif [[ $MEMORY_PERCENT -gt 60 ]]; then
  COLOR=0xffe0af68  # Yellow
else
  COLOR=0xff9ece6a  # Green
fi

sketchybar --set $NAME label="${MEMORY_PERCENT}%" label.color=$COLOR