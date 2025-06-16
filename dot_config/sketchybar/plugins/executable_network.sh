#!/bin/bash

# Only run on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
  exit 0
fi

# Get network status
NETWORK_NAME=$(networksetup -getairportnetwork en0 2>/dev/null | awk -F': ' '{print $2}')

if [[ -z "$NETWORK_NAME" ]]; then
  # Check for ethernet
  ETHERNET=$(ifconfig en0 | grep 'status: active')
  if [[ ! -z "$ETHERNET" ]]; then
    ICON=""
    LABEL="Ethernet"
  else
    ICON=""
    LABEL="Disconnected"
  fi
else
  ICON=""
  LABEL="$NETWORK_NAME"
fi

sketchybar --set $NAME icon="$ICON" label="$LABEL"