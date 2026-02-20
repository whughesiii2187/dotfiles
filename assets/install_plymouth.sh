#!/bin/sh

if ! yay -Qi "plymouth" &>/dev/null; then
  echo "plymouth not installed, installing now"
  yay -S --noconfirm --needed plymouth
else
  echo "plymouth already installed, skipping"
fi

