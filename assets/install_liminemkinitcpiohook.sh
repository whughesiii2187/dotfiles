#!/bin/sh

if ! yay -Qi "limine-mkinitcpio-hook" &>/dev/null; then
  echo "limine-mkinitcpio-hook not installed, installing now"
  yay -S --noconfirm --needed limine-mkinitcpio-hook
else
  echo "limine-mkinitcpio-hook already installed, skipping"
fi

