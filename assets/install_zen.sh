#!/bin/sh


if ! yay -Qi "zen-browser-bin" &>/dev/null; then
  echo "${GREEN}zen-browser-bin not installed, installing now ${NC}"
  yay -S --noconfirm --needed zen-browser-bin
else
  echo "${YELLOW}zen-browser-bin already installed, skipping ${NC}"
fi

