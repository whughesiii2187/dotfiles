#!/bin/sh

if ! yay -Qi "xdg-desktop-portal-hyprland" &>/dev/null; then
  echo "${GREEN}xdg-desktop-portal-hyprland not installed, installing now${NC}"
  yay -S --noconfirm --needed xdg-desktop-portal-hyprland
else
  echo "${YELLOW}xdg-desktop-portal-hyprland already installed, skipping${NC}"
fi

