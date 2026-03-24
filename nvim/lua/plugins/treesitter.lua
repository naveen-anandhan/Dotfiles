return {
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if opts.ensure_installed then
        vim.list_extend(
          opts.ensure_installed,
          { "bash", "html", "javascript", "json", "lua", "markdown", "python", "tsx", "typescript", "vim", "yaml", "sql" }
        )
      end
    end,
  },
}
