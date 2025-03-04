#!/bin/bash

echo "Updating the system..."
sudo pacman -Syu --noconfirm

echo "Installing apps..."
sudo pacman -S --noconfirm i3-wm i3status i3lock i3-gaps dmenu termite git neovim zsh kitty base-devel picom rofi ly kubectl chezmoi i3 xorg-server xorg-xinit xorg-xrandr xorg-xsetroot fzf xterm dunst

echo "Setting zsh as the default shell..."
if [[ "$SHELL" != "$(which zsh)" ]]; then
    chsh -s $(which zsh)
    echo "zsh is now the default shell."
else
    echo "zsh is already the default shell."
fi

echo "Checking for Oh My Zsh installation..."
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh is already installed."
fi

echo "Checking for Powerlevel10k installation..."
if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]]; then
    echo "Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc
else
    echo "Powerlevel10k is already installed."
fi

echo "Installing Nerdfonts..."
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
if [[ ! -f "Droid Sans Mono for Powerline Nerd Font Complete.otf" ]]; then
    curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
    fc-cache -fv
else
    echo "Nerdfonts are already installed."
fi

echo "Configuring kitty to use Nerdfonts..."
mkdir -p ~/.config/kitty
if ! grep -q "font_family DroidSansMono Nerd Font" ~/.config/kitty/kitty.conf 2>/dev/null; then
    echo "font_family DroidSansMono Nerd Font" >> ~/.config/kitty/kitty.conf
else
    echo "kitty is already configured to use Nerdfonts."
fi

zsh 

cp /etc/X11/xinit/xinitrc ~/.xinitrc

chezmoi init --apply Ruivalim
chezmoi update

sudo systemctl enable ly

echo "Installation complete! Please restart your terminal or log out and back in to apply changes."
