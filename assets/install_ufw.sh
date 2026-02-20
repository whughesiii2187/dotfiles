#!/bin/sh

if ! yay -Qi "ufw" &>/dev/null; then
  echo "ufw not installed, installing now"
  yay -S --noconfirm --needed ufw
else
  echo "ufw already installed, skipping"
fi

