#!/bin/sh

if ! yay -Qi "snap-pac" &>/dev/null; then
  echo "snap-pac not installed, installing now"
  yay -S --noconfirm --needed snap-pac
else
  echo "snap-pac already installed, skipping"
fi

