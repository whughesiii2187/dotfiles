#!/bin/sh

if ! yay -Qi "azure-cli" &>/dev/null; then
  echo "AzureCLI not installed, installing now"
  yay -S --noconfirm --needed azure-cli
else
  echo "AzureCLI already installed, skipping"
fi

