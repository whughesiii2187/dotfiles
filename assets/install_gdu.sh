#!/bin/sh

if ! yay -Qi "gdu" &>/dev/null; then
  echo "gdu not installed, installing now"
  yay -S --noconfirm --needed gdu
else
  echo "gdu already installed, skipping"
fi

