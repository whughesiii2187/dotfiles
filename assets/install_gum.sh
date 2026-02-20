#!/bin/sh

if ! yay -Qi "gum" &>/dev/null; then
  echo "gum not installed, installing now"
  yay -S --noconfirm --needed gum
else
  echo "gum already installed, skipping"
fi

