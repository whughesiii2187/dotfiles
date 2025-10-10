#!/bin/bash

# Use /tmp for all clone operations
cd /tmp
echo -e "${GREEN}Cloning from https://github.com/archlinux/aur.git...${NC}"

aurpkg+=("yay-bin")

for pkg in "${aurpkg[@]}"; do
  if $DRY_RUN; then
    echo "Installing from (aur github) $pkg"
  else
    echo -e "${GREEN}Fetching and installing $pkg...${NC}"
    git clone --branch "$pkg" --single-branch https://github.com/archlinux/aur.git "$pkg"
    cd "$pkg"
    makepkg -si --noconfirm
    cd ..
  fi
done

