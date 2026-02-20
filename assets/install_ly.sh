#!/bin/sh

if ! yay -Qi "ly" &>/dev/null; then
  echo "ly not installed, installing now"
  yay -S --noconfirm --needed ly
else
  echo "ly already installed, skipping"
fi

