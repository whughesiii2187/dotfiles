#!/bin/sh

if ! yay -Qi "usbutils" &>/dev/null; then
  echo "${GREEN}usbutils not installed, installing now${NC}"
  yay -S --noconfirm --needed usbutils
else
  echo "${YELLOW}usbutils already installed, skipping${NC}"
fi

