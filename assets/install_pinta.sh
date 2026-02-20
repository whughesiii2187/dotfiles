#!/bin/sh

if ! yay -Qi "pinta" &>/dev/null; then
  echo "pinta not installed, installing now"
  yay -S --noconfirm --needed pinta
else
  echo "pinta already installed, skipping"
fi

