#!/bin/sh

if ! yay -Qi "brightnessctl" &>/dev/null; then
  echo "brightnessctl not installed, installing now"
  yay -S --noconfirm --needed brightnessctl
else
  echo "brightnessctl already installed, skipping"
fi

