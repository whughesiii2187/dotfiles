#!/bin/sh

if ! yay -Qi "gtk4" &>/dev/null; then
  echo -e "${GREEN}gtk4 not installed, installing now${NC}"
  yay -S --noconfirm --needed gtk4
else
  echo -e "${YELLOW}gtk4 already installed, skipping${NC}"
fi

