#!/bin/bash
# Usage: ./script.sh <package-name>
# Alternative AUR installer when YAY is unavailable

PKG="${1:?Usage: $0 <package-name>}"

cd /tmp

echo -e "${GREEN}Fetching and installing ${PKG}...${NC}"
git clone --branch "$PKG" --single-branch https://github.com/archlinux/aur.git "$PKG"
cd "$PKG"
makepkg -si --noconfirm
