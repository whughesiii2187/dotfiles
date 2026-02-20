#!/bin/sh

if ! yay -Qi "slurp" &>/dev/null; then
  echo "slurp not installed, installing now"
  yay -S --noconfirm --needed slurp
else
  echo "slurp already installed, skipping"
fi
