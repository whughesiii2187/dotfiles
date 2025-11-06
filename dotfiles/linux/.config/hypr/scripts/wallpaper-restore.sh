#!/usr/bin/env bash
# -----------------------------------------------------
# Restore last wallpaper
# -----------------------------------------------------

# -----------------------------------------------------
# Set defaults
# -----------------------------------------------------

ml4w_cache_folder="$HOME/.cache/ml4w/hyprland-dotfiles"

defaultwallpaper="$HOME/.config/hypr/wallpapers/drums.jpg"

cachefile="$ml4w_cache_folder/current_wallpaper"

# -----------------------------------------------------
# Get current wallpaper
# -----------------------------------------------------

if [ -f "$cachefile" ]; then
    sed -i "s|~|$HOME|g" "$cachefile"
    wallpaper=$(cat $cachefile)
    if [ -f $wallpaper ]; then
        echo ":: Wallpaper $wallpaper exists"
    else
        echo ":: Wallpaper $wallpaper does not exist. Using default."
        wallpaper=$defaultwallpaper
    fi
else
    echo ":: $cachefile does not exist. Using default wallpaper."
    wallpaper=$defaultwallpaper
fi

# -----------------------------------------------------
# Set wallpaper
# -----------------------------------------------------

echo ":: Setting wallpaper with source image $wallpaper"
if [ -f ~/.local/bin/waypaper ]; then
    export PATH=$PATH:~/.local/bin/
fi
waypaper --wallpaper "$wallpaper"
