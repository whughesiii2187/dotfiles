#!/bin/sh

mkdir -p ~/.local/share
mkdir -p ~/.dotfiles
rm -rf ~/.config/hypr
rm -rf ~/.config/kitty

# ln -s /mnt/dotfiles-repo/dotfiles/.oh-my-zsh ~/.oh-my-zsh
# ln -s /mnt/dotfiles-repo/dotfiles/.tmux ~/.tmux
# ln -s /mnt/dotfiles-repo/dotfiles/.tmux.conf ~/.tmux.conf
# ln -s /mnt/dotfiles-repo/dotfiles/.zshrc ~/.zshrc
# ln -s /mnt/dotfiles-repo/dotfiles/.config/gtk-3.0 ~/.config/gtk-3.0
# ln -s /mnt/dotfiles-repo/dotfiles/.config/gtk-4.0 ~/.config/gtk-4.0
# ln -s /mnt/dotfiles-repo/dotfiles/.config/hypr ~/.config/hypr
# ln -s /mnt/dotfiles-repo/dotfiles/.config/kitty ~/.config/kitty
# ln -s /mnt/dotfiles-repo/dotfiles/.config/mako ~/.config/mako
# ln -s /mnt/dotfiles-repo/dotfiles/.config/nvim ~/.config/nvim
# ln -s /mnt/dotfiles-repo/dotfiles/.config/ohmyposh ~/.config/ohmyposh
# ln -s /mnt/dotfiles-repo/dotfiles/.config/walker ~/.config/walker
# ln -s /mnt/dotfiles-repo/dotfiles/.config/waybar ~/.config/waybar
# ln -s /mnt/dotfiles-repo/applications ~/.local/share/applications

cp -r applications ~/.local/share/

cp -r dotfiles/.* ~/.dotfiles
sleep 10
cd ~/.dotfiles
stow .
