#!/bin/sh

echo -e "${GREEN} Creating .local/share and .dotfiles in ~${NC}"
mkdir -p ~/.local/share
mkdir -p ~/.dotfiles
rm -rf ~/.config/hypr
rm -rf ~/.config/kitty

if [ ! -f ~/.zshrc ]; then
  echo -e "${GREEN}.zshrc file not found, not deleting ${NC}"
else
  rm ~/.zshrc
fi

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

echo -e "${GREEN}Stowing files... ${NC}"
cp -r applications ~/.local/share/

cp -r dotfiles/.* ~/.dotfiles
sleep 10
cd ~/.dotfiles
stow .
