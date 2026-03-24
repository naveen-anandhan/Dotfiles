return {
  -- 1. Colorscheme
  { "LazyVim/LazyVim", opts = { colorscheme = "gruvbox" } },
  { "ellisonleao/gruvbox.nvim" },

  -- 2. Disable Trouble
  { "folke/trouble.nvim", enabled = false },

  -- 3. Telescope
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
    },
  },

  -- 4. LSP & Treesitter
  { "neovim/nvim-lspconfig", opts = { servers = { pyright = {} } } },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if opts.ensure_installed then
        vim.list_extend(
          opts.ensure_installed,
          { "bash", "html", "javascript", "json", "lua", "markdown", "python", "tsx", "typescript", "vim", "yaml" }
        )
      end
    end,
  },

  -- 5. nvim-surround (Fixed for v4)
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      -- Call setup with an empty table to use v4 defaults and avoid the error
      require("nvim-surround").setup({})

      -- VS Code Style: Highlight + key = wrap
      local brackets = {
        ["("] = "(",
        [")"] = ")",
        ["["] = "[",
        ["]"] = "]",
        ["{"] = "{",
        ["}"] = "}",
        ['"'] = '"',
        ["'"] = "'",
      }

      for key, char in pairs(brackets) do
        vim.keymap.set("v", key, function()
          return "<Plug>(nvim-surround-visual)" .. char
        end, { remap = true, silent = true, expr = true })
      end
    end,
  },

  -- ✅ Dadbod
  { "tpope/vim-dadbod" },

  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod" },
    cmd = { "DBUI" },
  },

  -- 🚀 Flash.nvim (ADD THIS)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash Jump",
      },
    },
  },
  -- 6. Blink.cmp (The "Enter" fix)
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "default",
        ["<CR>"] = { "fallback" },
        ["<Tab>"] = { "select_and_accept", "fallback" },
      },
      completion = {
        documentation = { auto_show = false },
      },
    },
  },
}
