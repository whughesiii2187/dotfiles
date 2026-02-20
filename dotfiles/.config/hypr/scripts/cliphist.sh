#!/usr/bin/env bash
# -----------------------------------------------------
# Load Launcher
# -----------------------------------------------------
launcher=$(cat $HOME/.config/hypr/settings/launcher)

case $1 in
    d)
        if [ "$launcher" == "walker" ]; then
            cliphist list | $HOME/.config/walker/launch.sh -d -N -H -p "Search" | cliphist delete
        else
            cliphist list | rofi -dmenu -replace -config ~/.config/rofi/config-cliphist.rasi | cliphist delete
        fi
        ;;

    w)
        if [ "$launcher" == "walker" ]; then
            if [ $(echo -e "Clear\nCancel" | $HOME/.config/walker/launch.sh -d -n -N -H --maxheight 100) == "Clear" ]; then
                cliphist wipe
            fi
        else
            if [ $(echo -e "Clear\nCancel" | rofi -dmenu -config ~/.config/rofi/config-short.rasi) == "Clear" ]; then
                cliphist wipe
            fi
        fi
        ;;

    *)
        if [ "$launcher" == "walker" ]; then
            cliphist list | $HOME/.config/walker/launch.sh -d -N -H -p "Search" | cliphist decode | wl-copy
        else
            cliphist list | rofi -dmenu -replace -config ~/.config/rofi/config-cliphist.rasi | cliphist decode | wl-copy
        fi
        ;;
esac
