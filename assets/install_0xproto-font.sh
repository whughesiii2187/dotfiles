#!/bin/sh

if ! yay -Qi "ttf-0xproto-nerd" &>/dev/null; then
  echo "ttf-0xproto-nerd not installed, installing now"
  yay -S --noconfirm --needed ttf-0xproto-nerd
else
  echo "ttf-0xproto-nerd already installed, skipping"
fi

