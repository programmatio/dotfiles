#!/bin/bash

# Common utility functions for sketchybar plugins

# Check if a command exists
check_command() {
    local cmd=$1
    if ! command -v "$cmd" &> /dev/null; then
        return 1
    fi
    return 0
}

# Set error message in sketchybar
set_error() {
    local name=$1
    local message=$2
    sketchybar --set "$name" label="$message" icon.color=0xfff7768e label.color=0xfff7768e
}

# Check if running on macOS
is_macos() {
    [[ "$OSTYPE" == "darwin"* ]]
}

# Safe command execution with fallback
safe_exec() {
    local cmd=$1
    local fallback=$2
    local result
    
    result=$($cmd 2>/dev/null)
    if [ $? -ne 0 ] || [ -z "$result" ]; then
        echo "$fallback"
    else
        echo "$result"
    fi
}