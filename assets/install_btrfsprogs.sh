#!/bin/sh

if ! yay -Qi "btrfs-progs" &>/dev/null; then
  echo "btrfs-progs not installed, installing now"
  yay -S --noconfirm --needed btrfs-progs
else
  echo "btrfs-progs already installed, skipping"
fi

