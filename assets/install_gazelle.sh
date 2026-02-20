#!/bin/sh

if ! yay -Qi "gazelle-tui" &>/dev/null; then
  echo "gazelle-tui not installed, installing now"
  yay -S --noconfirm --needed gazelle-tui
else
  echo "gazelle-tui already installed, skipping"
fi

