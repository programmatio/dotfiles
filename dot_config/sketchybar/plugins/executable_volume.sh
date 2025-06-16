#!/bin/bash

# Get volume info
VOLUME=$(osascript -e 'get volume settings' | grep 'output volume' | cut -d':' -f2 | cut -d',' -f1 | tr -d ' ')
MUTED=$(osascript -e 'get volume settings' | grep 'output muted' | cut -d':' -f2 | tr -d ' ')

if [[ $MUTED == "true" ]]; then
  ICON=""
  LABEL="Muted"
elif [[ $VOLUME -eq 0 ]]; then
  ICON=""
  LABEL="0%"
elif [[ $VOLUME -lt 30 ]]; then
  ICON=""
  LABEL="${VOLUME}%"
elif [[ $VOLUME -lt 60 ]]; then
  ICON=""
  LABEL="${VOLUME}%"
else
  ICON=""
  LABEL="${VOLUME}%"
fi

sketchybar --set $NAME icon="$ICON" label="$LABEL"