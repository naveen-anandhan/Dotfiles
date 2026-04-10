-- Global Dadbod settings (Keep these at the top of the file)
vim.g.db_completion_column_res_with_alias = 1 -- Stop automatic backticks (``)
vim.g.vim_dadbod_completion_ignore_case = 1 -- Make searching case-insensitive
vim.g.vim_dadbod_completion_mark = "" -- Remove the [DB] tag to keep it clean

return {
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      "kristijanhusak/vim-dadbod-completion",
      "L3MON4D3/LuaSnip",
    },
    opts = {
      signature = { enabled = true },
      -- 1. Disable Ghost Text (the preview text)
      completion = {
        ghost_text = { enabled = false },
        documentation = { auto_show = true, auto_show_delay_ms = 200 }, -- Add this
      },

      -- 2. Set up your Keymaps (Tab to accept, C-j/C-k to move)
      keymap = {
        preset = "default",
        ["<Tab>"] = { "select_and_accept", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "show_signature", "fallback" }, -- Added show_signature here
      },

      -- 3. Configure Sources and Scoring
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "dadbod" },
        providers = {
          -- Give buffer words a high boost so common words like 'select' win
          buffer = {
            score_offset = 15,
          },
          -- Configure Dadbod to hide the "stupid" system noise
          dadbod = {
            name = "Dadbod",
            module = "vim_dadbod_completion.blink",
            score_offset = 2,
            -- This logic pushes system variables (with underscores) to the bottom
            transform_items = function(_, items)
              for _, item in ipairs(items) do
                if item.label:match("_") then
                  item.score_offset = -100
                end
              end
              return items
            end,
          },
        },
      },

      -- 4. Enable Snippets
      snippets = { preset = "luasnip" },
    },
  },
}
