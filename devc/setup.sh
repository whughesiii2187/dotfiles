#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

echo "Installing Brew"
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew update

echo "Installing packages"
brew install zsh
echo "/home/linuxbrew/.linuxbrew/bin/zsh" | sudo tee -a /etc/shells

echo "Installing oh-my-zsh"
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash

brew install neovim fzf lazygit zsh tmux claude-code font-0xproto-nerd-font gcc clipboard ripgrep tree-sitter-cli

### ----------------------------
### Dotfiles
### ----------------------------
echo "Applying dotfiles"
mkdir "$HOME/.config"

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

ln -sfn "$DOTFILES_DIR/dotfiles/.config/nvim" "$XDG_CONFIG_HOME/nvim"
ln -sfn "$DOTFILES_DIR/dotfiles/.tmux.conf" "$HOME/.tmux.conf"

ZSHRC="$HOME/.zshrc"
DOTFILE_ALIASES="$DOTFILES_DIR/dotfiles/.zshrc"

if [ -f "$ZSHRC" ]; then
  echo "source $DOTFILES_DIR/dotfiles/.zshrc" >>"$HOME/.zshrc"
else
  ln -sfn "$DOTFILES_DIR/dotfiles/.zshrc" "$HOME/.zshrc"
fi

echo "Dotfiles setup complete"
