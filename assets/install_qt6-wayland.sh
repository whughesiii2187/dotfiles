#!/bin/sh

if ! yay -Qi "qt6-wayland" &>/dev/null; then
  echo "qt6-wayland not installed, installing now"
  yay -S --noconfirm --needed qt6-wayland
else
  echo "qt6-wayland already installed, skipping"
fi
