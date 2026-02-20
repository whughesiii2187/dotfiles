#!/bin/sh

if ! yay -Qi "snapper" &>/dev/null; then
  echo "snapper not installed, installing now"
  yay -S --noconfirm --needed snapper
else
  echo "snapper already installed, skipping"
fi

