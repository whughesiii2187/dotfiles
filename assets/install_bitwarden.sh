#!/bin/sh

if ! yay -Qi "bitwarden" &>/dev/null; then
  echo "bitwarden not installed, installing now"
  yay -S --noconfirm --needed bitwarden
else
  echo "bitwarden already installed, skipping"
fi
