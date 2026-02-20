#!/bin/sh

if ! yay -Qi "lazygit" &>/dev/null; then
  echo "lazygit not installed, installing now"
  yay -S --noconfirm --needed lazygit
else
  echo "lazygit already installed, skipping"
fi

