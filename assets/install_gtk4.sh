#!/bin/sh

if ! yay -Qi "gtk4" &>/dev/null; then
  echo "${GREEN}gtk4 not installed, installing now${NC}"
  yay -S --noconfirm --needed gtk4
else
  echo "${YELLOW}gtk4 already installed, skipping${NC}"
fi

