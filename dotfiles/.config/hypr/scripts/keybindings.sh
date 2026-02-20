#!/usr/bin/env bash

# -----------------------------------------------------
# Get keybindings location based on variation
# -----------------------------------------------------
config_file=$"$HOME/.config/hypr/conf/keybinding.conf"

# -----------------------------------------------------
# Load Launcher
# -----------------------------------------------------
launcher=$(cat $HOME/.config/hypr/settings/launcher)

# -----------------------------------------------------
# Path to keybindings config file
# -----------------------------------------------------
echo "Reading from: $config_file"

keybinds=$(awk -F'[=#]' '
    $1 ~ /^bind/ {
        # Replace the string "$mainMod" with "SUPER" (for the super key)
        gsub(/\$mainMod/, "SUPER", $0)

        # Remove "bind" and extra spaces, if any, at the beginning of the line
        gsub(/^bind[[:space:]]*=+[[:space:]]*/, "", $0)

        # Split the keybinding part (e.g., "Mod1,Return") using a comma
        split($1, kbarr, ",")

        # Format the keybinding and associated command and prepare for output:
        # Concatenate the two keybinding keys (e.g., "Mod1" + "Return") and append the command
        print kbarr[1] " +" kbarr[2] " ->" $2
    }
' "$config_file")

sleep 0.2
if [ "$launcher" == "walker" ]; then
    keybinds=$(echo -n "$keybinds" | tr '\r' ':')
    $HOME/.config/walker/launch.sh -d -N -H -p "Search Keybinds" <<<"$keybinds"
else
    rofi -dmenu -i -markup -eh 2 -replace -p "Keybinds" -config ~/.config/rofi/config-compact.rasi <<<"$keybinds"
fi
