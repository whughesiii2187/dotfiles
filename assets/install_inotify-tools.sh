#!/bin/sh

if ! yay -Qi "inotify-tools" &>/dev/null; then
  echo "inotify-tools not installed, installing now"
  yay -S --noconfirm --needed inotify-tools
else
  echo "inotify-tools already installed, skipping"
fi

