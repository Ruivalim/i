#!/bin/bash

sudo pacman -Syu --noconfirm

sudo pacman -S --noconfirm i3-wm i3status i3lock i3-gaps dmenu git neovim zsh kitty base-devel picom rofi ly kubectl chezmoi i3 xorg-server xorg-xinit xorg-xrandr xorg-xsetroot fzf xterm dunst

curl -fsSL https://bun.sh/install | bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

if [[ "$SHELL" != "$(which zsh)" ]]; then
    chsh -s $(which zsh)
fi

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh is already installed."
fi


