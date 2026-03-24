return {
  -- Core DB plugin
  { "tpope/vim-dadbod" },

  -- UI
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      "tpope/vim-dadbod",
      "kristijanhusak/vim-dadbod-completion",
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection" },
  },

  -- Autocomplete for SQL
  {
    "kristijanhusak/vim-dadbod-completion",
    ft = { "sql", "mysql" },
  },

  -- Ensure SQL highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if opts.ensure_installed then
        vim.list_extend(opts.ensure_installed, { "sql" })
      end
    end,
  },
}
