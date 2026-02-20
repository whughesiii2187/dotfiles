#!/bin/bash

# Remove legacy shaders folder
if [ -d $HOME/.config/hypr/shaders ]; then
    rm -rf $HOME/.config/hypr/shaders
fi

# Toggle Hyprshade based on the selected filter
hyprshade_filter="blue-light-filter-50"

# Check if hyprshade.sh settings file exists and load
if [ -f ~/.config/hypr/settings/hyprshade.sh ]; then
    source ~/.config/hypr/settings/hyprshade.sh
fi

# Toggle Hyprshade
if [ "$hyprshade_filter" != "off" ]; then
    if [ -z $(hyprshade current) ]; then
        echo ":: hyprshade is not running"
        hyprshade on $hyprshade_filter
        notify-send "Hyprshade activated" "with $(hyprshade current)"
        echo ":: hyprshade started with $(hyprshade current)"
    else
        notify-send "Hyprshade deactivated"
        echo ":: Current hyprshade $(hyprshade current)"
        echo ":: Switching hyprshade off"
        hyprshade off
    fi
else
    hyprshade off
    echo ":: hyprshade turned off"
fi
