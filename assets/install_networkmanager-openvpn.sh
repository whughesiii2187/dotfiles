#!/bin/sh

if ! yay -Qi "networkmanager-openvpn" &>/dev/null; then
  echo "networkmanager-openvpn not installed, installing now"
  yay -S --noconfirm --needed networkmanager-openvpn
else
  echo "networkmanager-openvpn already installed, skipping"
fi

