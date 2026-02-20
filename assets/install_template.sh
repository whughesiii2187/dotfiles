#!/bin/sh

if ! yay -Qi "" &>/dev/null; then
  echo " not installed, installing now"
  yay -S --noconfirm -needed 
else
  echo " already installed, skipping"
fi

