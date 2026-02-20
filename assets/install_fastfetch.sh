#!/bin/sh

if ! yay -Qi "fastfetch" &>/dev/null; then
  echo "fastfetch not installed, installing now"
  yay -S --noconfirm --needed fastfetch
else
  echo "fastfetch already installed, skipping"
fi

