#!/bin/bash

# Battery monitoring script for i3
# Sends notifications when battery is low

BATTERY_PATH="/sys/class/power_supply/BAT1"
LOW_THRESHOLD=20
CRITICAL_THRESHOLD=10
CHECK_INTERVAL=60

# Track if we've already sent notifications to avoid spam
notified_low=false
notified_critical=false

while true; do
    if [ -f "$BATTERY_PATH/capacity" ] && [ -f "$BATTERY_PATH/status" ]; then
        capacity=$(cat "$BATTERY_PATH/capacity")
        status=$(cat "$BATTERY_PATH/status")
        
        # Only notify when discharging
        if [ "$status" = "Discharging" ]; then
            if [ "$capacity" -le "$CRITICAL_THRESHOLD" ] && [ "$notified_critical" = false ]; then
                notify-send -u critical "Battery Critical!" "Battery at ${capacity}% - Plug in charger immediately!" -i battery-caution
                notified_critical=true
                notified_low=true
            elif [ "$capacity" -le "$LOW_THRESHOLD" ] && [ "$capacity" -gt "$CRITICAL_THRESHOLD" ] && [ "$notified_low" = false ]; then
                notify-send -u normal "Battery Low" "Battery at ${capacity}% - Consider plugging in charger" -i battery-low
                notified_low=true
            fi
        else
            # Reset notifications when charging
            if [ "$capacity" -gt "$LOW_THRESHOLD" ]; then
                notified_low=false
                notified_critical=false
            fi
        fi
    fi
    
    sleep "$CHECK_INTERVAL"
done