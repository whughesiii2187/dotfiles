#!/bin/sh

if ! yay -Qi "kitty" &>/dev/null; then
  echo "kitty terminal not installed, installing now"
  yay -S --noconfirm --needed kitty
else
  echo "kitty terminal already installed, skipping"
fi
