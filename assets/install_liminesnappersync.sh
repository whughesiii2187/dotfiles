#!/bin/sh

if ! yay -Qi "limine-snapper-sync" &>/dev/null; then
  echo "limine-snapper-sync not installed, installing now"
  yay -S --noconfirm --needed limine-snapper-sync
else
  echo "limine-snapper-sync already installed, skipping"
fi

