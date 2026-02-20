#!/bin/sh

if ! yay -Qi "libreoffice-fresh" &>/dev/null; then
  echo "Office not installed, installing now"
  yay -S --needed --noconfirm libreoffice-fresh
else
  echo "Office already installed, skipping"
fi

