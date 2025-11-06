#!/bin/bash
set -euo pipefail

echo -e "${GREEN}Updating system...${NC}"
sudo pacman -Syu --noconfirm

echo -e "${GREEN}Installing official repo packages...${NC}"
for pkg in "${pacpkg[@]}"; do
  if $DRY_RUN; then
    echo "Installing (pacman): $pkg"
  else
    sudo pacman -S --noconfirm --needed "$pkg"
  fi
done

# Install yay (AUR helper)
# Check if aur.archlinux.org is up
echo -e "${GREEN}Checking if aur.archlinux.org is reachable...${NC}"
URL="https://aur.archlinux.org"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$URL")
if [ "$STATUS" -eq 200 ]; then
  echo -e "${GREEN}AUR is up. Installing yay from aur.archlinux.org...${NC}"
  source "$ASSETS_DIR"/yay.sh
else
  echo -e "${GREEN}aur.archlinux.org is DOWN. Falling back to GitHub AUR mirror...${NC}"
  source "$ASSETS_DIR"/yay-down.sh
fi

# Install Astronvim dependencies
# for pkg in "${astrodeps[@]}"; do
#   echo -e "${GREEN} Installing Astronvim dependencies $pkg...${NC}"
#   sudo npm install "$pkg"
# done

if [ ! -f ~/.zshrc ]; then
  echo -e "${GREEN}.zshrc file not found, not deleting ${NC}"
else
  rm ~/.zshrc
fi

# stow dotfiles
cd /tmp/dotfiles/dotfiles
mkdir ~/.dotfiles 
cp -r shared/.* ~/.dotfiles/
cd ~/.dotfiles

if [[ "$DESKTOP" == "hypr" ]]; then
  cp -r linux/.* ~/.dotfiles/
  stow .
else
  stow .
fi

# Enable services
echo -e "${GREEN}Enabling services...${NC}"
sudo systemctl enable bluetooth.service
sudo systemctl enable power-profiles-daemon.service
sudo systemctl enable NetworkManager.service
sudo systemctl stop systemd-networkd && sudo systemctl disable systemd-networkd
systemctl --user enable pipewire.socket pipewire-pulse.socket wireplumber.service pipewire.service 2>/dev/null || true

if [[ "$DESKTOP" == "hypr" ]]; then
  sudo systemctl enable ly
else
  sudo systemctl enable cosmic-greeter.service
fi

#Install Qemu/KVM for virtual machines
# echo -e "${GREEN}Installing QEMU/KVM Virtual Machine packages... ${NC}"
# source "$ASSETS_DIR"/7-kvm.sh

# Set Zsh as default shell
if [[ "$SHELL" != "/bin/zsh" ]]; then
  echo -e "${GREEN}Setting Zsh as default shell...${NC}"
  chsh -s "$(which zsh)"
fi

echo -e "${GREEN}PLEASE CHANGE YOUR PASSWORD NOW ${NC}"
passwd

echo -e "${GREEN}✅ Done!! Rebooting system in 30 seconds... ${NC}"
sleep 30s
reboot
