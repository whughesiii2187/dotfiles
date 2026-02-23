#!/bin/sh

if ! yay -Qi "inetutils" &>/dev/null; then
  echo -e "${GREEN}inetutils not installed, installing now${NC}"
  yay -S --noconfirm --needed inetutils
else
  echo -e "${YELLOW}inetutils already installed, skipping${NC}"
fi

