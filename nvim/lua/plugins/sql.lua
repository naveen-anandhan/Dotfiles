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
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_database_icon = 1
      -- Pre-configure local dev SQLite database so DBUI works immediately out of the box
      vim.g.dbs = {
        {
          name = "dev",
          url = "sqlite:" .. vim.fn.expand("~/Documents/sql/dev.db"),
        },
      }
    end,
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
