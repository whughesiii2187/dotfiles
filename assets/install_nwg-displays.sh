#!/bin/sh

if ! yay -Qi "nwg-displays" &>/dev/null; then
  echo "nwg-displays not installed, installing now"
  yay -S --noconfirm --needed nwg-displays
else
  echo "nwg-displays already installed, skipping"
fi

