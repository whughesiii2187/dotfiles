#!/bin/sh

if ! yay -Qi "powershell-bin" &>/dev/null; then
  echo "Powershell not installed, installing now"
  yay -S --noconfirm --needed powershell-bin
else
  echo "Powershell already installed, skipping"
fi

