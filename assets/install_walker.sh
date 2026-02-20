#!/bin/sh

packages="
walker-bin
elephant
elephant-desktopapplications
elephant-bluetooth
elephant-calc
elephant-clipboard
elephant-files
elephant-menus
elephant-providerList
elephant-runner
elephant-symbols
elephant-todo
elephant-unicode
elephant-websearch"

for pkg in $packages; do
  if ! yay -Qi "$pkg" &>/dev/null; then
    echo "${GREEN}$pkg not installed, installing now${NC}"
    yay -S --noconfirm --needed "$pkg"
  else
    echo "${YELLOW}$pkg already installed, skipping${NC}"
  fi
done
