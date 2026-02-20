#!/bin/sh

if ! yay -Qi "fd" &>/dev/null; then
  echo "fd not installed, installing now"
  yay -S --noconfirm --needed fd
else
  echo "fd already installed, skipping"
fi

