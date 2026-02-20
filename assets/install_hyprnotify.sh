#!/bin/sh

if ! yay -Qi "hyprnotify" &>/dev/null; then
  echo "hyprnotify not installed, installing now"
  yay -S --noconfirm --needed hyprnotify
else
  echo "hyprnotify already installed, skipping"
fi

