#!/bin/sh

if ! yay -Qi "ripgrep" &>/dev/null; then
  echo -e "${GREEN}ripgrep not installed, installing now${NC}"
  yay -S --noconfirm --needed ripgrep
else
  echo -e "${YELLOW}ripgrep already installed, skipping${NC}"
fi

