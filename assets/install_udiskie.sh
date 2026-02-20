#!/bin/sh

if ! yay -Qi "udiskie" &>/dev/null; then
  echo "udiskie not installed, installing now"
  yay -S --noconfirm --needed udiskie
else
  echo "udiskie already installed, skipping"
fi

