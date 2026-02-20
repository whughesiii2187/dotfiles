#!/bin/sh

if ! yay -Qi "wireguard-tools" &>/dev/null; then
  echo "${GREEN}wireguard-tools not installed, installing now${NC}"
  yay -S --noconfirm --needed wireguard-tools
else
  echo "${YELLOW}wireguard-tools already installed, skipping${NC}"
fi

