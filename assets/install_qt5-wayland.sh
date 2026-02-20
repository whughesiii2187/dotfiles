#!/bin/sh

if ! yay -Qi "qt5-wayland" &>/dev/null; then
  echo "qt5-wayland not installed, installing now"
  yay -S --noconfirm --needed qt5-wayland
else
  echo "qt5-wayland already installed, skipping"
fi

