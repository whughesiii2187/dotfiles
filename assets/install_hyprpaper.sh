#!/bin/sh

if ! yay -Qi "hyprpaper" &>/dev/null; then
  echo "hyprpaper not installed, installing now"
  yay -S --noconfirm --needed hyprpaper
else
  echo "hyprpaper already installed, skipping"
fi

