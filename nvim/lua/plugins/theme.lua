return {
  -- Your themes
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "folke/tokyonight.nvim", priority = 1000 },
  { "rebelot/kanagawa.nvim" },
  { "rose-pine/neovim", name = "rose-pine" },
  { "sainnhe/gruvbox-material" },
  { "EdenEast/nightfox.nvim" },

  -- Set the initial theme here instead of inside the LazyVim opts
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin", -- This sets the initial boot theme
    },
  },
}
