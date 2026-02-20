#!/bin/sh

if ! yay -Qi "figlet" &>/dev/null; then
  echo "${GREEN}figlet not installed, installing now${NC}"
  yay -S --noconfirm --needed figlet
else
  echo "${YELLOW}figlet already installed, skipping${NC}"
fi

