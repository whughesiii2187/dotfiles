#!/bin/sh

if ! yay -Qi "wl-clipboard" &>/dev/null; then
  echo "wl-clipboard not installed, installing now"
  yay -S --noconfirm --needed wl-clipboard
else
  echo "wl-clipboard already installed, skipping"
fi

