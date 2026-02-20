#!/bin/sh

if ! yay -Qi "modemmanager" &>/dev/null; then
  echo "modemmanager not installed, installing now"
  yay -S --noconfirm --needed modemmanager
else
  echo "modemmanager already installed, skipping"
fi

