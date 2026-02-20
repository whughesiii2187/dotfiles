#!/bin/sh

packages="zsh oh-my-posh"

for pkg in $packages; do
  if ! yay -Qi "$pkg" &>/dev/null; then
    echo "${GREEN}$pkg not installed, installing now ${NC}"
    yay -S --noconfirm --needed "$pkg" 
  else
    echo "${YELLOW}$pkg already installed, skipping ${NC}"
  fi
done

chsh -s $(which zsh)

if [ ! -f ~/.zshrc ]; then
  echo -e "${GREEN}.zshrc file not found, not deleting ${NC}"
else
  rm ~/.zshrc
fi

