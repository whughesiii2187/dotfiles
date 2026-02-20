#!/bin/sh

if ! yay -Qi "limine-update" &>/dev/null; then
  echo "limine-update not installed, installing now"
  yay -S --noconfirm --needed limine-update
else
  echo "limine-update already installed, skipping"
fi

