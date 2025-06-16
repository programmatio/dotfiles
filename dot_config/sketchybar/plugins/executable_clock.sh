#!/bin/bash

# Format matching i3status: "2023-10-20 15:30:00"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

sketchybar --set $NAME label="$DATE"