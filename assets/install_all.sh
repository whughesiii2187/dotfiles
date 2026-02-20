#!/bin/sh

## Install Utilities
"$ASSETS_DIR"/install_power.sh
"$ASSETS_DIR"/install_fastfetch.sh
"$ASSETS_DIR"/install_gdu.sh
"$ASSETS_DIR"/install_gum.sh
"$ASSETS_DIR"/install_gtk4.sh
"$ASSETS_DIR"/install_unzip.sh
"$ASSETS_DIR"/install_wget.sh
"$ASSETS_DIR"/install_figlet.sh
"$ASSETS_DIR"/install_brightness.sh
"$ASSETS_DIR"/install_nwg-displays.sh
"$ASSETS_DIR"/install_udiskie.sh
"$ASSETS_DIR"/install_ufw.sh
"$ASSETS_DIR"/install_xdg-user-dirs.sh
"$ASSETS_DIR"/install_fzf.sh
"$ASSETS_DIR"/install_lazygit.sh
"$ASSETS_DIR"/install_fd.sh
"$ASSETS_DIR"/install_usbutils.sh
"$ASSETS_DIR"/install_inetutils.sh
"$ASSETS_DIR"/install_bind.sh
"$ASSETS_DIR"/install_ripgrep.sh
"$ASSETS_DIR"/install_clipboard.sh
"$ASSETS_DIR"/install_wayland.sh
"$ASSETS_DIR"/install_qt5-wayland.sh
"$ASSETS_DIR"/install_qt6-wayland.sh
"$ASSETS_DIR"/install_xdg-desktopportal-hyprland.sh
"$ASSETS_DIR"/install_xdg-desktopportal-gtk.sh
"$ASSETS_DIR"/install_stow.sh
"$ASSETS_DIR"/install_tmux.sh
"$ASSETS_DIR"/install_btop.sh
"$ASSETS_DIR"/install_networkmanager.sh
"$ASSETS_DIR"/install_wireguard-tools.sh
"$ASSETS_DIR"/install_screenshots.sh
"$ASSETS_DIR"/install_modemmanager.sh
"$ASSETS_DIR"/install_printer-utils.sh
"$ASSETS_DIR"/install_networkmanager-openvpn.sh

## Install Fonts
"$ASSETS_DIR"/install_0xproto-font.sh
"$ASSETS_DIR"/install_awesome-font.sh
"$ASSETS_DIR"/install_firacode-font.sh
"$ASSETS_DIR"/install_firacodenerd-font.sh
"$ASSETS_DIR"/install_firasans-font.sh

## Install Audio
"$ASSETS_DIR"/install_bluetooth.sh
"$ASSETS_DIR"/install_audio.sh

## Install Apps
"$ASSETS_DIR"/install_libreoffice.sh
"$ASSETS_DIR"/install_neovim.sh
"$ASSETS_DIR"/install_vlc.sh
"$ASSETS_DIR"/install_thunar.sh
"$ASSETS_DIR"/install_spotify.sh
"$ASSETS_DIR"/install_evince.sh
"$ASSETS_DIR"/install_pinta.sh
"$ASSETS_DIR"/install_kitty.sh
"$ASSETS_DIR"/install_slurp.sh
"$ASSETS_DIR"/install_bitwarden.sh
"$ASSETS_DIR"/install_zen.sh
"$ASSETS_DIR"/install_gazelle.sh
# "$ASSETS_DIR"/install_podman.sh
# "$ASSETS_DIR"/install_powershell.sh
# "$ASSETS_DIR"/install_azurecli.sh

## Install Hyprland and requirements
"$ASSETS_DIR"/install_hyprland.sh
"$ASSETS_DIR"/install_hyprlock.sh
"$ASSETS_DIR"/install_hyprutils.sh
"$ASSETS_DIR"/install_hyprpaper.sh
"$ASSETS_DIR"/install_hypridle.sh
"$ASSETS_DIR"/install_hyprnotify.sh
"$ASSETS_DIR"/install_walker.sh
"$ASSETS_DIR"/install_waybar.sh
"$ASSETS_DIR"/install_wayfreeze.sh
"$ASSETS_DIR"/install_wlogout.sh
"$ASSETS_DIR"/install_ly.sh
"$ASSETS_DIR"/install_mako.sh
"$ASSETS_DIR"/install_zsh.sh

## Install Encryption and Snapshot utils
# "$ASSETS_DIR"/install_plymouth.sh
# "$ASSETS_DIR"/install_optimus.sh
# "$ASSETS_DIR"/install_snapper.sh
# "$ASSETS_DIR"/install_liminesnappersync.sh
# "$ASSETS_DIR"/install_limineupdate.sh
# "$ASSETS_DIR"/install_liminemkinitcpiohook.sh
# "$ASSETS_DIR"/install_btrfsprogs.sh

## Clone and Stow Dotfiles ##
if [ -d ~/.dotfiles/.config ]; then
  echo "Dotfiles appear to be installed already, skipping"
else
  "$ASSETS_DIR"/install_dotfiles.sh
fi

## Setup VPN ##
# ./install_vpn.sh
