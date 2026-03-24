return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = { pyright = {} },
      setup = {
        -- This disables the automatic floating window for signature help
        ["*"] = function()
          vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = "rounded",
            focusable = false,
            -- This is the key: it prevents the window from stealing focus
            -- or popping up automatically if configured this way.
          })
        end,
      },
    },
  },
  -- Alternatively, if you use Noice.lua (standard in LazyVim)
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        signature = {
          enabled = false, -- This completely kills that popup
        },
      },
    },
  },
}
