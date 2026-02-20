#!/bin/sh

if ! yay -Qi "mako" &>/dev/null; then
  echo "mako not installed, installing now"
  yay -S --noconfirm --needed mako
else
  echo "mako already installed, skipping"
fi

