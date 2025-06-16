#!/bin/bash

# Check dependencies
if ! command -v yabai &> /dev/null; then
    sketchybar --set $NAME label="yabai not found"
    exit 1
fi

if ! command -v jq &> /dev/null; then
    sketchybar --set $NAME label="jq not found"
    exit 1
fi

# Get current window title
WINDOW_TITLE=$(yabai -m query --windows --window 2>/dev/null | jq -r '.title' 2>/dev/null || echo "No window")

# Truncate if too long
if [ ${#WINDOW_TITLE} -gt 50 ]; then
  WINDOW_TITLE=$(echo "$WINDOW_TITLE" | cut -c 1-47)"..."
fi

sketchybar --set $NAME label="$WINDOW_TITLE"