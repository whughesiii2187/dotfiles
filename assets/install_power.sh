#!/bin/sh

packages="tlp tlp-pd"

for pkg in $packages; do
  if ! yay -Qi "$pkg" &>/dev/null; then
    echo "$pkg not installed, installing now"
    yay -S --noconfirm --needed "$pkg"
  else
    echo "$pkg already installed, skipping"
  fi
done
