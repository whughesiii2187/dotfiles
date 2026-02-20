#!/bin/sh

if ! yay -Qi "hypridle" &>/dev/null; then
  echo "hypridle not installed, installing now"
  yay -S --noconfirm --needed hypridle
else
  echo "hypridle already installed, skipping"
fi

