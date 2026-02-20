#!/bin/sh

if ! yay -Qi "hyprland" &>/dev/null; then
  echo "hyprland not installed, installing now"
  yay -S --noconfirm --needed hyprland
else
  echo "hyprland already installed, skipping"
fi

