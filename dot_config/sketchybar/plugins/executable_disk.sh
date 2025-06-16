#!/bin/bash

# Get disk usage for root partition
DISK_USAGE=$(df -H / | awk 'NR==2 {print $5}' | sed 's/%//')

# Color based on disk usage
if [[ $DISK_USAGE -gt 80 ]]; then
  COLOR=0xfff7768e  # Red
elif [[ $DISK_USAGE -gt 60 ]]; then
  COLOR=0xffe0af68  # Yellow
else
  COLOR=0xff9ece6a  # Green
fi

sketchybar --set $NAME label="${DISK_USAGE}%" label.color=$COLOR