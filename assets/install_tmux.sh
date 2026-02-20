#!/bin/sh

if ! yay -Qi "tmux" &>/dev/null; then
  echo "tmux not installed, installing now"
  yay -S --noconfirm --needed tmux
else
  echo "tmux already installed, skipping"
fi

