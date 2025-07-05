#!/bin/bash

# Battery bling script - makes i3bar flash on low battery

BATTERY_PATH="/sys/class/power_supply/BAT1"
CRITICAL_THRESHOLD=15
URGENT_WORKSPACE="BATTERY LOW!"

while true; do
    if [ -f "$BATTERY_PATH/capacity" ] && [ -f "$BATTERY_PATH/status" ]; then
        capacity=$(cat "$BATTERY_PATH/capacity")
        status=$(cat "$BATTERY_PATH/status")
        
        if [ "$status" = "Discharging" ] && [ "$capacity" -le "$CRITICAL_THRESHOLD" ]; then
            # Flash the bar by toggling urgent hint on a temporary workspace
            i3-msg "workspace $URGENT_WORKSPACE" >/dev/null 2>&1
            i3-msg "mark battery_urgent" >/dev/null 2>&1
            sleep 0.5
            i3-msg "workspace back_and_forth" >/dev/null 2>&1
            sleep 2
        else
            sleep 30
        fi
    else
        sleep 30
    fi
done