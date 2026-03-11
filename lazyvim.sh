#!/bin/bash

#    chmod +x lazyvim.sh
#    ./lazyvim.sh

set -e

echo "Updating and adding PPA..."
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update

echo "Installing Neovim, Tmux, Starship and dev tools..."
sudo apt install -y \
  neovim git curl ripgrep fd-find \
  build-essential unzip \
  nodejs npm python3-venv python3-pip \
  tmux starship

echo "Cleaning old configs..."
# We use -rf so it doesn't ask for permission if files don't exist
rm -rf ~/.config/nvim ~/.tmux.conf ~/.config/starship.toml ~/Dotfiles

echo "Cloning dotfiles..."
git clone https://github.com/naveen-anandhan/Dotfiles.git ~/Dotfiles

echo "Linking configs..."
mkdir -p ~/.config

# Added -sfn to ensure the script doesn't fail if you run it again later
ln -sfn ~/Dotfiles/nvim ~/.config/nvim
# Ensure the tmux and starship folders exist in your repo before linking!
ln -sfn ~/Dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sfn ~/Dotfiles/starship/starship.toml ~/.config/starship.toml

echo "Installing tmux plugin manager..."
# Check if it exists first to avoid error messages
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "Adding starship to bashrc..."
if ! grep -q "starship init bash" ~/.bashrc; then
  echo 'eval "$(starship init bash)"' >> ~/.bashrc
fi

echo "Fixing fd command for telescope..."
mkdir -p ~/.local/bin
# Use -sf to overwrite if the link already exists
ln -sf $(which fdfind) ~/.local/bin/fd

echo "--------------------------------"
echo "Setup complete!"
echo "Current Neovim version (should be 0.11+):"
nvim --version | head -n 1
echo "--------------------------------"
echo "Restart your terminal or run: source ~/.bashrc"
