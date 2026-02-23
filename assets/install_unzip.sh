#!/bin/sh

if ! yay -Qi "unzip" &>/dev/null; then
  echo -e "${GREEN}unzip not installed, installing now${NC}"
  yay -S --noconfirm --needed unzip
else
  echo -e "${YELLOW}unzip already installed, skipping${NC}"
fi

