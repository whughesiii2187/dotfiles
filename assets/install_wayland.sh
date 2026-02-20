#!/bin/sh

if ! yay -Qi "wayland" &>/dev/null; then
  echo "${GREEN}wayland not installed, installing now${NC}"
  yay -S --noconfirm --needed wayland
else
  echo "${YELLOW}wayland already installed, skipping${NC}"
fi

