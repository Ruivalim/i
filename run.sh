#!/bin/bash

echo "Updating the system..."
sudo pacman -Syu --noconfirm

echo "Installing apps..."
sudo pacman -S --noconfirm i3 git neovim zsh kitty yay picom rofi ly 

echo "Installing kubectl, kubectx, and kubens..."
sudo pacman -S --noconfirm kubectl
yay -S --noconfirm kubectx

echo "Installing chezmoi..."
sudo pacman -S --noconfirm chezmoi

echo "Setting zsh as the default shell..."
chsh -s $(which zsh)

echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "Installing Powerlevel10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc

echo "Installing Nerdfonts..."
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
fc-cache -fv

echo "Configuring kitty to use Nerdfonts..."
mkdir -p ~/.config/kitty
echo "font_family DroidSansMono Nerd Font" >> ~/.config/kitty/kitty.conf

echo "Installation complete! Please restart your terminal or log out and back in to apply changes."
