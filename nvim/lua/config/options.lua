vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "

-- Ensure ~/.local/bin is in PATH for Neovim and child processes (e.g. jupyter kernelspec)
local local_bin = vim.fn.expand("~/.local/bin")
if not string.find(vim.env.PATH or "", local_bin, 1, true) then
  vim.env.PATH = local_bin .. ":" .. (vim.env.PATH or "")
end

vim.opt.swapfile = false

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.wo.number = true
