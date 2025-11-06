#!/bin/bash

if ! command -v yay; then
  cd /tmp
  git clone https://aur.archlinux.org/yay-bin.git
  cd yay-bin
  makepkg -si --noconfirm
  cd ~
else
  echo -e "${GREEN} Yay is already installed, adding packages!!${NC}"
fi

if [[ "$DESKTOP" == "hypr" ]]; then
  echo -e "${GREEN}Installing AUR packages with yay...${NC}"
  yay -Syu --noconfirm
  for pkg in "${aurpkg[@]}"; do
    if $DRY_RUN; then
      echo "Installing (aur): $pkg"
    else
      yay -S --noconfirm --needed "$pkg"
    fi
  done
fi
