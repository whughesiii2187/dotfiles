#!/bin/sh

if ! yay -Qi "wayfreeze" &>/dev/null; then
  echo "${GREEN}wayfreeze not installed, installing now${NC}"
  yay -S --noconfirm --needed wayfreeze
else
  echo "${YELLOW}wayfreeze already installed, skipping${NC}"
fi

