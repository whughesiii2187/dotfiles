#!/bin/sh

if ! yay -Qi "fzf" &>/dev/null; then
  echo "fzf not installed, installing now"
  yay -S --noconfirm --needed fzf
else
  echo "fzf already installed, skipping"
fi

