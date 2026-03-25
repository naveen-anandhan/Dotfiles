return {
  -- themes (just plugins, no config here)
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "folke/tokyonight.nvim", priority = 1000 },
  { "rebelot/kanagawa.nvim" },
  { "rose-pine/neovim", name = "rose-pine" },
  { "sainnhe/gruvbox-material" },
  { "ellisonleao/gruvbox.nvim" },
  { "EdenEast/nightfox.nvim" },

  -- ✅ ONLY ONE place to set theme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox", -- 👈 change theme here
    },
  },
}
