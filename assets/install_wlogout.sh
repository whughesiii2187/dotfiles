#!/bin/sh

if ! yay -Qi "wlogout" &>/dev/null; then
  echo "${GREEN}wlogout not installed, installing now${NC}"
  yay -S --noconfirm --needed wlogout
else
  echo "${YELLOW}wlogout already installed, skipping${NC}"
fi

