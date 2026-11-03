# 📓 Jupyter Notebook (`ipynb.nvim`) Guide

This setup integrates **`ajbucci/ipynb.nvim`** and **`folke/snacks.nvim`** for native Jupyter notebook editing and execution inside Neovim.

---

## ⚡ Keybindings Cheatsheet

### 🧭 Navigation & Modes
* `i` or `<Enter>`: **Enter Cell Edit Mode** (cursor inside cell code, active cell highlighted)
* `<Esc>`: **Exit to Notebook Mode** (navigate whole cells)
* `]]` or `<Ctrl + j>`: **Jump to Next Cell** (works seamlessly in both Notebook and Edit modes)
* `[[` or `<Ctrl + k>`: **Jump to Previous Cell** (works seamlessly in both Notebook and Edit modes)
* `<leader>kj`: Open fuzzy cell picker

### ➕ Cell Management
* `<leader>kb`: Add new cell **below**
* `<leader>ka`: Add new cell **above**
* `<leader>kd` (or `dd` in Notebook Mode): **Cut / Delete current cell** (shows notification; undo with `u`, paste with `p`)
* In **Edit Mode**: `dd` deletes a line of code as normal in Vim
* `p` / `P`: Paste cut cell below / above
* `<Alt + j>`: Move current cell down
* `<Alt + k>`: Move current cell up
* `<leader>ky`: Convert cell to **Code**
* `<leader>km`: Convert cell to **Markdown**

### 🚀 Execution & Kernel
* `<leader>ks`: **Start** Python kernel
* `<Ctrl + Enter>` (or `<leader>kx`): **Execute** cell
* `<Shift + Enter>` (or `<leader>kX`): **Execute & Move to Next**
* `<leader>k0`: Restart kernel
* `<leader>kS`: Shutdown kernel
* `<leader>kn`: Check kernel status
* `<Ctrl + c>`: Interrupt execution

### 🔍 Outputs & Inspection
* `<leader>ko` (or `:NotebookOutput`): **View current cell output** in a floating window (shows exact cell output, copyable with `Y`, close with `q` or `<Esc>`)
* `<leader>kc`: Clear current cell output
* `<leader>kC`: Clear all outputs
* `<leader>kh`: Inspect variable at cursor
* `<leader>kv`: Inspect all variables in cell
