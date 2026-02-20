#!/bin/sh

if ! yay -Qi "gum" &>/dev/null; then
  echo "${GREEN}gtk4 not installed, installing now${NC}"
  yay -S --noconfirm --needed gtk4
else
  echo "${YELLOW}gum already installed, skipping${NC}"
fi

