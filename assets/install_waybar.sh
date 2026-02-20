#!/bin/sh

if ! yay -Qi "waybar" &>/dev/null; then
  echo "${GREEN}waybar not installed, installing now${NC}"
  yay -S --noconfirm --needed waybar
else
  echo "${YELLOW}waybar already installed, skipping${NC}"
fi

