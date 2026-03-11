#!/bin/bash

#    chmod +x lazyvim.sh
#    ./lazyvim.sh

set -e

echo "Installing dependencies..."

sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update

sudo apt install -y \
  neovim git curl ripgrep fd-find \
  build-essential unzip \
  nodejs npm python3-venv python3-pip \
  tmux starship

echo "Cleaning old configs..."

rm -rf ~/.config/nvim
rm -rf ~/.tmux.conf
rm -rf ~/.config/starship.toml

echo "Cloning dotfiles..."

git clone https://github.com/naveen-anandhan/Dotfiles.git ~/Dotfiles

echo "Linking configs..."

mkdir -p ~/.config

ln -s ~/Dotfiles/nvim ~/.config/nvim
ln -s ~/Dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -s ~/Dotfiles/starship/starship.toml ~/.config/starship.toml

mkdir -p ~/.local/bin
ln -sf $(which fdfind) ~/.local/bin/fd

echo "--------------------------------"
echo "Setup complete!"
echo "Neovim version:"
nvim --version | head -n 1
echo "--------------------------------"
