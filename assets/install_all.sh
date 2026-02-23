#!/bin/sh

## Install Utilities
source "$ASSETS_DIR"/install_power.sh
source "$ASSETS_DIR"/install_fastfetch.sh
source "$ASSETS_DIR"/install_gdu.sh
source "$ASSETS_DIR"/install_gum.sh
source "$ASSETS_DIR"/install_gtk4.sh
source "$ASSETS_DIR"/install_unzip.sh
source "$ASSETS_DIR"/install_wget.sh
source "$ASSETS_DIR"/install_figlet.sh
source "$ASSETS_DIR"/install_brightness.sh
source "$ASSETS_DIR"/install_nwg-displays.sh
source "$ASSETS_DIR"/install_udiskie.sh
source "$ASSETS_DIR"/install_ufw.sh
source "$ASSETS_DIR"/install_xdg-user-dirs.sh
source "$ASSETS_DIR"/install_fzf.sh
source "$ASSETS_DIR"/install_lazygit.sh
source "$ASSETS_DIR"/install_fd.sh
source "$ASSETS_DIR"/install_usbutils.sh
source "$ASSETS_DIR"/install_inetutils.sh
source "$ASSETS_DIR"/install_bind.sh
source "$ASSETS_DIR"/install_ripgrep.sh
source "$ASSETS_DIR"/install_clipboard.sh
source "$ASSETS_DIR"/install_wayland.sh
source "$ASSETS_DIR"/install_qt5-wayland.sh
source "$ASSETS_DIR"/install_qt6-wayland.sh
source "$ASSETS_DIR"/install_xdg-desktopportal-hyprland.sh
source "$ASSETS_DIR"/install_xdg-desktopportal-gtk.sh
source "$ASSETS_DIR"/install_stow.sh
source "$ASSETS_DIR"/install_tmux.sh
source "$ASSETS_DIR"/install_btop.sh
source "$ASSETS_DIR"/install_networkmanager.sh
source "$ASSETS_DIR"/install_wireguard-tools.sh
source "$ASSETS_DIR"/install_modemmanager.sh
source "$ASSETS_DIR"/install_printer-utils.sh
source "$ASSETS_DIR"/install_networkmanager-openvpn.sh

## Install Fonts
source "$ASSETS_DIR"/install_0xproto-font.sh
source "$ASSETS_DIR"/install_awesome-font.sh
source "$ASSETS_DIR"/install_firacode-font.sh
source "$ASSETS_DIR"/install_firacodenerd-font.sh
source "$ASSETS_DIR"/install_firasans-font.sh

## Install Audio
source "$ASSETS_DIR"/install_bluetooth.sh
source "$ASSETS_DIR"/install_audio.sh

## Install Apps
source "$ASSETS_DIR"/install_libreoffice.sh
source "$ASSETS_DIR"/install_neovim.sh
source "$ASSETS_DIR"/install_vlc.sh
source "$ASSETS_DIR"/install_thunar.sh
source "$ASSETS_DIR"/install_spotify.sh
source "$ASSETS_DIR"/install_evince.sh
source "$ASSETS_DIR"/install_pinta.sh
source "$ASSETS_DIR"/install_kitty.sh
source "$ASSETS_DIR"/install_slurp.sh
source "$ASSETS_DIR"/install_bitwarden.sh
source "$ASSETS_DIR"/install_zen.sh
source "$ASSETS_DIR"/install_gazelle.sh
source "$ASSETS_DIR"/install_podman.sh
source "$ASSETS_DIR"/install_powershell.sh
source "$ASSETS_DIR"/install_azurecli.sh
source "$ASSETS_DIR"/install_screenshots.sh

## Install Hyprland and requirements
source "$ASSETS_DIR"/install_hyprland.sh
source "$ASSETS_DIR"/install_hyprlock.sh
source "$ASSETS_DIR"/install_hyprutils.sh
source "$ASSETS_DIR"/install_hyprpaper.sh
source "$ASSETS_DIR"/install_hypridle.sh
source "$ASSETS_DIR"/install_hyprnotify.sh
source "$ASSETS_DIR"/install_walker.sh
source "$ASSETS_DIR"/install_waybar.sh
source "$ASSETS_DIR"/install_wayfreeze.sh
source "$ASSETS_DIR"/install_wlogout.sh
source "$ASSETS_DIR"/install_ly.sh
source "$ASSETS_DIR"/install_mako.sh
source "$ASSETS_DIR"/install_zsh.sh

## Install Encryption and Snapshot utils
# source "$ASSETS_DIR"/install_plymouth.sh
# source "$ASSETS_DIR"/install_optimus.sh
source "$ASSETS_DIR"/install_snapper.sh
source "$ASSETS_DIR"/install_liminesnappersync.sh
source "$ASSETS_DIR"/install_inotify-tools.sh
source "$ASSETS_DIR"/install_limineupdate.sh
source "$ASSETS_DIR"/install_liminemkinitcpiohook.sh
source "$ASSETS_DIR"/install_btrfsprogs.sh
source "$ASSETS_DIR"/config-limine-snapper.sh

## Clone and Stow Dotfiles ##
if [ -d ~/.dotfiles/.config ]; then
  echo "Dotfiles appear to be installed already, skipping"
else
  "$ASSETS_DIR"/install_dotfiles.sh
fi

## Setup VPN ##
# ./install_vpn.sh
