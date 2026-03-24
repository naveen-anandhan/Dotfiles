return {
  -- nvim-surround (Fixed for v4)
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
}