#!/bin/sh

if ! yay -Qi "unzip" &>/dev/null; then
  echo "${GREEN}unzip not installed, installing now${NC}"
  yay -S --noconfirm --needed unzip
else
  echo "${YELLOW}unzip already installed, skipping${NC}"
fi

