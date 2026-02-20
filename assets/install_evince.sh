#!/bin/sh

if ! yay -Qi "evince" &>/dev/null; then
  echo "evince not installed, installing now"
  yay -S --noconfirm --needed evince
else
  echo "evince already installed, skipping"
fi

