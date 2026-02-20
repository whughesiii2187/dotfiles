#!/bin/sh

if ! yay -Qi "networkmanager" &>/dev/null; then
  echo "networkmanager not installed, installing now"
  yay -S --noconfirm --needed networkmanager
else
  echo "networkmanager already installed, skipping"
fi

