#!/bin/bash

# ==============================================================================
# Complete Neovim, Tmux, Starship, Jupyter Notebook & SQL DBUI Setup Script
# Usage:
#   chmod +x lazyvim.sh
#   ./lazyvim.sh
# ==============================================================================

set -e

echo "🚀 Step 1/8: Updating package repositories and adding Neovim unstable PPA..."
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update

echo "📦 Step 2/8: Installing system packages and developer tools..."
sudo apt install -y \
  neovim git curl ripgrep fd-find \
  build-essential unzip \
  nodejs npm python3-venv python3-pip \
  tmux starship zsh \
  sqlite3 libsqlite3-dev

echo "📁 Step 3/8: Preparing local directories and PATH..."
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.config/Code/User"

# Ensure ~/.local/bin is in PATH for bash and zsh
for rc in "$HOME/.bashrc" "$HOME/.zshrc"; do
  if [ -f "$rc" ] && ! grep -q 'export PATH=.*\.local/bin' "$rc"; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$rc"
  fi
done
export PATH="$HOME/.local/bin:$PATH"

# Fix fd command for telescope
if command -v fdfind &>/dev/null; then
  ln -sf "$(which fdfind)" "$HOME/.local/bin/fd"
fi

# Fallback: install standalone sqlite3 binary in ~/.local/bin if not in PATH
if ! command -v sqlite3 &>/dev/null; then
  echo "Installing standalone sqlite3 to ~/.local/bin..."
  mkdir -p /tmp/sqlite_dl
  curl -sSL https://www.sqlite.org/2024/sqlite-tools-linux-x64-3460100.zip -o /tmp/sqlite_dl/sqlite.zip
  unzip -qo /tmp/sqlite_dl/sqlite.zip sqlite3 -d "$HOME/.local/bin/" || true
  chmod +x "$HOME/.local/bin/sqlite3" || true
  rm -rf /tmp/sqlite_dl
fi

echo "🔄 Step 4/8: Cloning or updating Dotfiles..."
if [ ! -d "$HOME/Dotfiles" ]; then
  git clone https://github.com/naveen-anandhan/Dotfiles.git "$HOME/Dotfiles"
else
  echo "Dotfiles already present at $HOME/Dotfiles. Pulling latest..."
  git -C "$HOME/Dotfiles" pull || true
fi

echo "🔗 Step 5/8: Linking configurations..."
ln -sfn "$HOME/Dotfiles/nvim" "$HOME/.config/nvim"
ln -sfn "$HOME/Dotfiles/tmux/tmux.conf" "$HOME/.tmux.conf"
ln -sfn "$HOME/Dotfiles/starship/starship.toml" "$HOME/.config/starship.toml"
ln -sfn "$HOME/Dotfiles/vs_code_settings.json" "$HOME/.config/Code/User/settings.json"

echo "📓 Step 6/8: Setting up Python & Jupyter Notebook environment..."
pip3 install --user --break-system-packages jupyter_client ipykernel pynvim || pip3 install --user jupyter_client ipykernel pynvim
python3 -m ipykernel install --user --name python3 --display-name "Python 3"

mkdir -p "$HOME/Documents/Python"
if [ ! -f "$HOME/Documents/Python/notebook.ipynb" ]; then
  cat << 'EOF' > "$HOME/Documents/Python/notebook.ipynb"
{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "print('Hello from Jupyter in Neovim!')\n"
   ]
  }
 ],
 "metadata": {
  "language_info": {
   "name": "python"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
EOF
fi

if [ -f "$HOME/Dotfiles/nvim/IPYNB_GUIDE.md" ]; then
  cp "$HOME/Dotfiles/nvim/IPYNB_GUIDE.md" "$HOME/Documents/Python/README.md"
fi

echo "🗄️ Step 7/8: Setting up SQL & Database environment..."
mkdir -p "$HOME/Documents/sql"
mkdir -p "$HOME/.local/share/db_ui"

# Create starter sample database dev.db if not present
if [ ! -f "$HOME/Documents/sql/dev.db" ]; then
  echo "Creating starter dev.db database in ~/Documents/sql/dev.db..."
  sqlite3 "$HOME/Documents/sql/dev.db" << 'EOF'
CREATE TABLE IF NOT EXISTS departments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

INSERT INTO departments (name) VALUES 
('Engineering'),
('Marketing'),
('Data Science');

CREATE TABLE IF NOT EXISTS employees (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    department_id INTEGER,
    salary REAL,
    FOREIGN KEY(department_id) REFERENCES departments(id)
);

INSERT INTO employees (name, department_id, salary) VALUES 
('Navi', 1, 95000),
('Alice', 3, 105000),
('Bob', 2, 72000),
('Charlie', 1, 88000);
EOF
fi

# Create starter practice.sql if not present
if [ ! -f "$HOME/Documents/sql/practice.sql" ]; then
  cat << 'EOF' > "$HOME/Documents/sql/practice.sql"
-- Pre-connected database: dev (~/Documents/sql/dev.db)
-- Press <Space>r to run this query!

SELECT * FROM employees;

SELECT 
    e.name AS employee_name,
    d.name AS department_name,
    e.salary
FROM employees e
JOIN departments d ON e.department_id = d.id
ORDER BY e.salary DESC;
EOF
fi

# Copy SQL guide to ~/Documents/sql/README.md
if [ -f "$HOME/Dotfiles/nvim/SQL_GUIDE.md" ]; then
  cp "$HOME/Dotfiles/nvim/SQL_GUIDE.md" "$HOME/Documents/sql/README.md"
fi

# Pre-populate DBUI saved connection for dev.db if not present
if [ ! -f "$HOME/.local/share/db_ui/connections.json" ]; then
  echo '[{"url": "sqlite:'"$HOME"'/Documents/sql/dev.db", "name": "dev"}]' > "$HOME/.local/share/db_ui/connections.json"
fi

echo "🪟 Step 8/8: Setting up Tmux, Starship, and Neovim plugins..."
# Tmux plugin manager
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

tmux new-session -d -s setup 2>/dev/null || true
"$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh" 2>/dev/null || true
tmux kill-server 2>/dev/null || true

# Starship in zsh
if [ -f "$HOME/.zshrc" ] && ! grep -q "starship init zsh" "$HOME/.zshrc"; then
  echo 'eval "$(starship init zsh)"' >> "$HOME/.zshrc"
fi

# Set zsh as default shell if available
if command -v zsh &>/dev/null && [ "$SHELL" != "$(which zsh)" ]; then
  sudo chsh -s "$(which zsh)" "$USER" || true
fi

# Sync Neovim plugins headlessly
echo "Syncing Neovim plugins via Lazy..."
nvim --headless "+Lazy! sync" +qa 2>/dev/null || true

echo "---------------------------------------------------------"
echo "🎉 Setup complete! All tools are installed and configured:"
echo "---------------------------------------------------------"
echo "• Neovim version: $(nvim --version | head -n 1)"
echo "• SQLite3:        $(sqlite3 --version 2>/dev/null | cut -d' ' -f1-3 || echo 'installed')"
echo "• Python Kernel:  $(python3 --version) (registered in Jupyter)"
echo "• SQL Practice:   ~/Documents/sql/practice.sql"
echo "• Jupyter File:   ~/Documents/Python/notebook.ipynb"
echo "---------------------------------------------------------"
echo "Documentation Guides:"
echo "• Keybindings: ~/Dotfiles/nvim/KEYBINDINGS.md"
echo "• SQL Guide:   ~/Dotfiles/nvim/SQL_GUIDE.md"
echo "• IPYNB Guide: ~/Dotfiles/nvim/IPYNB_GUIDE.md"
echo "---------------------------------------------------------"
echo "To start, restart your terminal or run: source ~/.zshrc"
