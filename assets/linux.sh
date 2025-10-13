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
  source $ASSETS_DIR/yay.sh
else
  echo -e "${GREEN}aur.archlinux.org is DOWN. Falling back to GitHub AUR mirror...${NC}"
  source $ASSETS_DIR/yay-down.sh
fi

# Install OhMyZSH
echo -e "${GREEN}Installing OhMyZSH...${NC}"
export RUNZSH=no
export CHSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Powerlevel10k theme
echo -e "${GREEN}Installing Powerlevel10k theme...${NC}"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

# Install Astronvim dependencies
for pkg in "${astrodeps[@]}"; do
  echo -e "${GREEN} Installing Astronvim dependencies $pkg...${NC}"
  sudo npm install "$pkg"
done

if [[ "$DESKTOP" == "hypr" ]]; then
  # Hyprland Settings App
  ml4w_app="com.ml4w.hyprlandsettings"
  ml4w_app_repo="hyprland-settings"
  echo ":: Installing $ml4w_app"
  bash -c "$(curl -s https://raw.githubusercontent.com/mylinuxforwork/$ml4w_app_repo/master/setup.sh)"
fi

# stow dotfiles
cd /tmp/dotfiles
mv dotfiles ~/
cd ~/dotfiles/
rm ~/.zshrc
stow */

# Enable services
echo -e "${GREEN}Enabling services...${NC}"
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now power-profiles-daemon.service
sudo systemctl enable cosmic-greeter.service
sudo systemctl enable --now NetworkManager.service
sudo systemctl stop systemd-networkd && sudo systemctl disable systemd-networkd
systemctl --user enable --now pipewire.socket pipewire-pulse.socket 2>/dev/null || true

## Anything else to do??
# Set Zsh as default shell
if [[ "$SHELL" != "/bin/zsh" ]]; then
  echo -e "${GREEN}Setting Zsh as default shell...${NC}"
  chsh -s "$(which zsh)"
fi

echo -e "{GREEN}PLEASE CHANGE YOUR PASSWORD NOW"
passwd

echo -e "${GREEN}✅ Done!! Rebooting system in 30 seconds... ${NC}"
sleep 30s
reboot
