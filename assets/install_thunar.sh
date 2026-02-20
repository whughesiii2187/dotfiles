#!/bin/sh

if ! yay -Qi "thunar" &>/dev/null; then
  echo "Thunar not installed, installing now"
  yay -S --noconfirm --needed thunar
else
  echo "Thunar already installed, skipping"
fi

