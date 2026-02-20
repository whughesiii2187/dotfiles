#!/bin/sh


if ! yay -Qi "stow" &>/dev/null; then
  echo "stow not installed, installing now"
  yay -S --noconfirm --needed stow
else
  echo "stow already installed, skipping"
fi
