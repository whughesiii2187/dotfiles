#!/bin/sh

#!/usr/bin/env bash
set -euo pipefail

# Helper function to install a package
install_pkg() {
    local pkg="$1"
    
    echo "Installing $pkg..."

    # Try yay first
    if command -v yay &>/dev/null; then
        if yay -S --noconfirm --needed "$pkg"; then
            echo "$pkg installed via yay."
            return 0
        else
            echo "yay failed for $pkg. Sending to yay-down.sh..."
            bash yay-down.sh "$pkg" && return 0
        fi
    # If yay is not available, try the helper script
    elif [[ -f ./yay-down.sh ]]; then
        if bash yay-down.sh "$pkg"; then
            echo "$pkg installed via yay-down.sh."
            return 0
        fi
    fi

    # Fallback to pacman
    echo "Installing $pkg via pacman..."
    sudo pacman -S --noconfirm --needed "$pkg"
}

# Package groups
core_packages=(
btrfs-progs brightnessctl cups cups-browsed cups-filter cups-pdf dust fd gazelle-tui gdu inetutils inotify-tools snapper limine-mkinitcpio-hook limine-snapper-sync limine-snapper-watcher snap-pac nwg-displays ly modemmanager networkmanager networkmanager-openvpn plymouth plymouth-theme-optimus-git stow tlp tlp-pd udiskie ufw unzip usbutils wget wireguard-tools zsh
)

hypr_packages=(
elephant elephant-bluetooth elephant-calc elephant-clipboard elephant-desktopapplications elephant-files elephant-menus elephant-providerList elephant-runner elephant-symbols elephant-todo elephant-unicode elephant-websearch gpu-screen-recorder hplip hypridle hyprland hyprland-guiutils hyprland-preview-share-picker hyprlock hyprnotify hyprpaper hyprsunset mako swayosd system-config-printer walker-bin waybar wayfreeze wayland wl-clipboard xdg-desktop-portal-gtk xdg-desktop-portal-hyprland xdg-user-dirs gtk3 gtk4 qt5-wayland qt6-wayland grim slurp
)

audio_packages=(
bluez bluez-obex bluez-utils bluetuith pamixer pipewire pipewire-jack pipewire-pulse playerctl wiremix wireplumber ffplay vlc
)

fonts_packages=(
otf-font-awesome ttf-0xproto-nerd ttf-fira-code ttf-firacode-nerd ttf-fira-sans
)

apps_packages=(
azure-cli bind bitwarden btop evince fastfetch kitty lazygit libreoffice-fresh neovim pinta podman podman-compose podman-docker powershell-bin ripgrep spotify thunar tmux zen-browser-bin figlet fzf gum ohmyposh satty
)

# Loop through all groups
for group in core_packages hypr_packages audio_packages fonts_packages apps_packages; do
    echo "=== Installing group: $group ==="
    for pkg in "${!group}"; do
        install_pkg "$pkg"
    done
done

echo -e "${GREEN}All packages installed successfully!${NC}"

echo -e "${GREEN} Configure limine and snapper for snapshots${NC}"

source "$ASSETS_DIR"/config-limine-snapper.sh

## Clone and Stow Dotfiles ##
if [ -d ~/.dotfiles/.config ]; then
  echo -e "${YELLOW}Dotfiles appear to be installed already, skipping${NC}"
else
  source "$ASSETS_DIR"/install_dotfiles.sh
fi

## Setup VPN ##
# ./install_vpn.sh
