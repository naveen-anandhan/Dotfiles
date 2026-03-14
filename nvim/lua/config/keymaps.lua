-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>tt", "<cmd>Telescope colorscheme<cr>", { desc = "Theme Switcher" })
vim.keymap.set("i", "<S-Tab>", "<C-d>", { desc = "Unindent" })
vim.keymap.set("n", "<S-Tab>", "<<", { desc = "Unindent line" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Unindent selection" })


vim.keymap.set("i", "<C-h>", "<Left>",  { noremap = true })
vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true })
vim.keymap.set("i", "<C-j>", "<Down>",  { noremap = true })
vim.keymap.set("i", "<C-k>", "<Up>",    { noremap = true })

-- In init.lua
vim.keymap.set({'n', 'v'}, 'd', '"_d')
vim.keymap.set({'n', 'v'}, 'dd', '"_dd')

vim.keymap.set("n", "<leader>r", ":w | belowright split | terminal python3 %<CR>")

