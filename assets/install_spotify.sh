#!/bin/sh

if ! yay -Qi "spotify" &>/dev/null; then
  echo "spotify not installed, installing now"
  yay -S --noconfirm --needed spotify
else
  echo "spotify already installed, skipping"
fi

