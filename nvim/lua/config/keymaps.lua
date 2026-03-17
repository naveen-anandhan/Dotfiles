-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- Existing Theme Switcher
vim.keymap.set("n", "<leader>tt", "<cmd>Telescope colorscheme<cr>", { desc = "Theme Switcher" })

-- Indenting (Tab / Shift-Tab)
vim.keymap.set("i", "<S-Tab>", "<C-d>", { desc = "Unindent" })
vim.keymap.set("n", "<Tab>", ">>", { desc = "Indent line" })
vim.keymap.set("n", "<S-Tab>", "<<", { desc = "Unindent line" })
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent selection" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Unindent selection" })

-- Insert Mode Navigation
vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true })
vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true })
vim.keymap.set("i", "<C-j>", "<Down>", { noremap = true })
vim.keymap.set("i", "<C-k>", "<Up>", { noremap = true, silent = true, desc = "Move Up" })


-- Escape with jk
vim.keymap.set("i", "jk", "<Esc>", { noremap = true })
vim.keymap.set("v", "jk", "<Esc>", { noremap = true })

-- Visual Mode: Move Lines (ThePrimeagen Style)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Visual Mode: i goes to Insert Mode
vim.keymap.set("v", "i", "<Esc>i", { noremap = true })

-- Black Hole Register Deletion (Doesn't overwrite clipboard)
vim.keymap.set({ "n", "v" }, "d", '"_d')
vim.keymap.set("n", "dd", '"_dd')

-- Try both common escape codes for Ctrl + /
vim.keymap.set("n", "<C-_>", "gcc", { remap = true, desc = "Toggle comment" })
vim.keymap.set("n", "<C-/>", "gcc", { remap = true, desc = "Toggle comment" })

vim.keymap.set("v", "<C-_>", "gc", { remap = true, desc = "Toggle comment" })
vim.keymap.set("v", "<C-/>", "gc", { remap = true, desc = "Toggle comment" })

-- Disable auto popup (hover + signature)
vim.lsp.handlers["textDocument/hover"] = function() end
vim.lsp.handlers["textDocument/signatureHelp"] = function() end

-- Show docs manually
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show docs" })
