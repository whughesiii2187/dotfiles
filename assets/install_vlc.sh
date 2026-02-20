#!/bin/sh

if ! yay -Qi "vlc" &>/dev/null; then
  echo "${GREEN}VLC not installed, installing now${NC}"
  yay -S --noconfirm --needed vlc
else
  echo "${YELLOW}VLC already installed, skipping${NC}"
fi

