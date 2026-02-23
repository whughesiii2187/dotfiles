#!/bin/sh

if ! yay -Qi "figlet" &>/dev/null; then
  echo -e "${GREEN}figlet not installed, installing now${NC}"
  yay -S --noconfirm --needed figlet
else
  echo -e "${YELLOW}figlet already installed, skipping${NC}"
fi

