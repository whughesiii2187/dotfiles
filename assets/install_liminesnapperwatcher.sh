#!/bin/sh

if ! yay -Qi "limine-snapper-watcher" &>/dev/null; then
  echo "limine-snapper-watcher not installed, installing now"
  yay -S --noconfirm --needed limine-snapper-watcher
else
  echo "limine-snapper-watcher already installed, skipping"
fi

