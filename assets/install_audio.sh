#!/bin/sh

packages="pipewire pipewire-jack pipewire-pulse wireplumber wiremix ffplay playerctl pamixer"

for pkg in $packages; do
  if ! yay -Qi "$pkg" &>/dev/null; then
    echo "$pkg not installed, installing now"
    yay -S --noconfirm --needed "$pkg"
  else
    echo "$pkg already installed, skipping"
  fi
done
