#!/bin/sh

if ! yay -Qi "hyprlock" &>/dev/null; then
  echo "hyprlock not installed, installing now"
  yay -S --noconfirm --needed hyprlock
else
  echo "hyprlock already installed, skipping"
fi

