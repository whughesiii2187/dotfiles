#!/usr/bin/env bash

if [ -f $HOME/.config/hypr/settings/waybar-disabled ]; then
    rm $HOME/.config/hypr/settings/waybar-disabled
else
    touch $HOME/.config/hypr/settings/waybar-disabled
fi
$HOME/.config/waybar/launch.sh &
