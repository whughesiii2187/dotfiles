#!/bin/sh

if ! yay -Qi "xdg-user-dirs" &>/dev/null; then
  echo "${GREEN}xdg-user-dirs not installed, installing now${NC}"
  yay -S --noconfirm --needed xdg-user-dirs
else
  echo "${YELLOW}xdg-user-dirs already installed, skipping${NC}"
fi
