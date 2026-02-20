#!/bin/sh

if ! yay -Qi "xdg-desktop-portal-gtk" &>/dev/null; then
  echo "${GREEN}xdg-desktop-portal-gtk not installed, installing now${NC}"
  yay -S --noconfirm --needed xdg-desktop-portal-gtk
else
  echo "${YELLOW}xdg-desktop-portal-gtk already installed, skipping${NC}"
fi

