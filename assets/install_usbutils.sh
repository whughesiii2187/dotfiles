#!/bin/sh

if ! yay -Qi "usbutils" &>/dev/null; then
  echo -e "${GREEN}usbutils not installed, installing now${NC}"
  yay -S --noconfirm --needed usbutils
else
  echo -e "${YELLOW}usbutils already installed, skipping${NC}"
fi

