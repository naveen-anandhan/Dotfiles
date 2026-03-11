return {
  -- Your current themes
  { "catppuccin/nvim", name = "catppuccin", priority = 1000, opts = { flavour = "mocha" } },
  { "folke/tokyonight.nvim", priority = 1000, opts = { style = "storm" } },

  -- New themes to try
  { "rebelot/kanagawa.nvim" },
  { "rose-pine/neovim", name = "rose-pine" },
  { "sainnhe/gruvbox-material" },
  { "EdenEast/nightfox.nvim" },

  -- Default setting
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
