# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

plugins=(git kubectl helm)

eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/default.omp.toml)"
source $ZSH/oh-my-zsh.sh

# Aliases
alias vim="nvim"
alias vi="nvim"
alias v="nvim"

fastfetch
