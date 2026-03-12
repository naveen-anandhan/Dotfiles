#!/bin/bash

# chmod +x lazyvim.sh
# ./lazyvim.sh

set -e

echo "Updating and adding PPA..."
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update

echo "Installing Neovim, Tmux, Starship and dev tools..."
sudo apt install -y \
  neovim git curl ripgrep fd-find \
  build-essential unzip \
  nodejs npm python3-venv python3-pip \
  tmux starship zsh

echo "Cleaning old configs..."
rm -rf ~/.config/nvim ~/.tmux.conf ~/.config/starship.toml ~/Dotfiles

echo "Cloning dotfiles..."
git clone https://github.com/naveen-anandhan/Dotfiles.git ~/Dotfiles

echo "Linking configs..."
mkdir -p ~/.config

ln -sfn ~/Dotfiles/nvim ~/.config/nvim
ln -sfn ~/Dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sfn ~/Dotfiles/starship/starship.toml ~/.config/starship.toml

echo "Installing tmux plugin manager..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "Installing tmux plugins..."
tmux new-session -d -s setup
~/.tmux/plugins/tpm/scripts/install_plugins.sh
tmux kill-server

echo "Adding starship to zshrc..."
if ! grep -q "starship init zsh" ~/.zshrc; then
  echo 'eval "$(starship init zsh)"' >> ~/.zshrc
fi

echo "Setting zsh as default shell..."
chsh -s $(which zsh)

echo "Fixing fd command for telescope..."
mkdir -p ~/.local/bin
ln -sf "$(which fdfind)" ~/.local/bin/fd

echo "--------------------------------"
echo "Setup complete!"
echo "Current Neovim version:"
nvim --version | head -n 1
echo "--------------------------------"
echo "Restart terminal or run: source ~/.zshrc"
