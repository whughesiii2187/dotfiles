#!/bin/sh

if ! yay -Qi "kitty" &>/dev/null; then
  echo "Neovim not installed, installing now"
  yay -S --noconfirm --needed neovim
else
  echo "Neovim already installed, skipping"
fi

