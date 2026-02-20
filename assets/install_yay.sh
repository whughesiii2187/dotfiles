#!/bin/bash

if ! command -v yay; then
  if [ ! -d /tmp/yay-bin ]; then
    echo -e "${GREEN} Yay being installed installed...${NC}"
    git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
    cd /tmp/yay-bin
    makepkg -si --noconfirm
  fi
  cd $SCRIPT_DIR
fi

