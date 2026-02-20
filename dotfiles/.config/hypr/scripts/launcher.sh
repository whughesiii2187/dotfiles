#!/usr/bin/env bash

# -----------------------------------------------------
# Load Launcher
# -----------------------------------------------------
launcher=$(cat $HOME/.config/hypr/settings/launcher)

# Use Walker
_launch_walker() {
    $HOME/.config/walker/launch.sh "$@"
}

if [ "$launcher" == "walker" ]; then
    _launch_walker "$@"
fi
