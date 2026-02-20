#!/bin/sh

if ! yay -Qi "wget" &>/dev/null; then
  echo "${GREEN}wget not installed, installing now${NC}"
  yay -S --noconfirm --needed wget
else
  echo "${YELLOW}wget already installed, skipping${NC}"
fi

