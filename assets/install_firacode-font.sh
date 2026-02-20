#!/bin/sh

if ! yay -Qi "ttf-fira-code" &>/dev/null; then
  echo "ttf-fira-code not installed, installing now"
  yay -S --noconfirm --needed ttf-fira-code
else
  echo "ttf-fira-code already installed, skipping"
fi

