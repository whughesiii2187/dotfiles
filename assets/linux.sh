#!/bin/bash
set -euo pipefail

echo -e "${GREEN}Updating system...${NC}"
sudo pacman -Syu --noconfirm

# Install yay (AUR helper)
# Check if aur.archlinux.org is up
echo -e "${GREEN}Checking if aur.archlinux.org is reachable...${NC}"
URL="https://aur.archlinux.org"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$URL")
if [ "$STATUS" -eq 200 ]; then
  echo -e "${GREEN}AUR is up. Installing yay from aur.archlinux.org...${NC}"
  source "$ASSETS_DIR"/install_yay.sh
fi

## Install_All
source "$ASSETS_DIR"/install_all.sh

# Enable services
echo -e "${GREEN}Enabling services...${NC}"
sudo systemctl enable ly@tty2.service
sudo systemctl enable bluetooth.service
sudo systemctl enable tlp.service
sudo systemctl enable --now tlp-pd.service
sudo systemctl enable --now swayosd-libinput-backend.service
sudo systemctl stop iwd systemd-networkd && systemctl disable iwd systemd-networkd
sudo systemctl stop systemd-networkd && sudo systemctl disable systemd-networkd
sudo systemctl stop wpa_supplicant && sudo systemctl disable wpa_supplicant
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager
sudo systemctl enable limine-snapper-sync.service
sudo systemctl start limine-snapper-sync.service
systemctl --user enable pipewire.socket pipewire-pulse.socket wireplumber.service pipewire.service 2>/dev/null || true
elephant service enable

# Setup Plymouth, snapper snapshots
sudo plymouth-set-default-theme optimus
sudo mkinitcpio -P

echo -e "${GREEN}✅ Done!! Rebooting system in 30 seconds... ${NC}"
sleep 30s
reboot
