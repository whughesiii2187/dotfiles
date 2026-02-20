#!/bin/sh

if ! yay -Qi "ttf-firacode-nerd" &>/dev/null; then
  echo "ttf-firacode-nerd not installed, installing now"
  yay -S --noconfirm --needed ttf-firacode-nerd
else
  echo "ttf-firacode-nerd already installed, skipping"
fi

