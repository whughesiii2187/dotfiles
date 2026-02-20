#!/bin/sh

if ! yay -Qi "ttf-fira-sans" &>/dev/null; then
  echo "ttf-fira-sans not installed, installing now"
  yay -S --noconfirm --needed ttf-fira-sans
else
  echo "ttf-fira-sans already installed, skipping"
fi

