#!/bin/sh

if ! yay -Qi "otf-font-awesome" &>/dev/null; then
  echo "otf-font-awesome not installed, installing now"
  yay -S --noconfirm --needed otf-font-awesome
else
  echo "otf-font-awesome already installed, skipping"
fi

