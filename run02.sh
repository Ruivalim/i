git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc

git clone https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts && ./install.sh

cp /etc/X11/xinit/xinitrc ~/.xinitrc

chezmoi init --apply Ruivalim
chezmoi update

sudo systemctl enable ly

