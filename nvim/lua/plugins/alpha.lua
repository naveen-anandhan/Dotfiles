return {
  -- Disable snacks dashboard
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = { enabled = false },
    },
  },

  -- Alpha dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- =========================
      -- 🔥 HEADER (ASCII)
      -- =========================
      dashboard.section.header.val = {
        [[                                                                 ]],
        [[                                         █▀█▀█                    ]],
        [[                                         █▄█▄█                     ]],
        [[                                          ███  ▄▄                  ]],
        [[                                       ███▐▐                ]],
        [[       ████ ██████ █████   ██    █████        ████ ██████  ]],
        [[      ███████████   █████        ▀ ▀▀▀▀▀▀     ███████████     ]],
        [[      █████████ ████████ █████████████████ █████████   ]],
        [[     █████████ █████████████ ██    ██    █████████   ]],
        [[    █████████ ██ ████████████████████ █████████       ]],
        [[  ████████████████████ ██    ██   ███████████   ]],
        [[ ██████  ██████   ███████████████████████  ███        ]],
        [[                                                                        ]],
      }

      -- ✅ Apply highlight to header
      dashboard.section.header.opts.hl = "DashboardHeader"

      -- =========================
      -- ⚡ BUTTONS
      -- =========================
      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find File", ":Telescope find_files <CR>"),
        dashboard.button("n", "  New File", ":ene <BAR> startinsert <CR>"),
        dashboard.button("g", "  Find Text", ":Telescope live_grep <CR>"),
        dashboard.button("r", "  Recent Files", ":Telescope oldfiles <CR>"),
        dashboard.button("c", "  Config", ":e ~/.config/nvim/init.lua <CR>"),
        dashboard.button("s", "  Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
        dashboard.button("x", "  Lazy Extras", ":LazyExtras <CR>"),
        dashboard.button("l", "󰒲  Lazy", ":Lazy <CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }

      -- Alias SessionRestore command just in case user runs it manually
      vim.api.nvim_create_user_command("SessionRestore", function()
        require("persistence").load()
      end, {})

      -- optional styling
      dashboard.section.buttons.opts.hl = "DashboardCenter"

      -- =========================
      -- 📝 FOOTER
      -- =========================
      dashboard.section.footer.val = {
        "🚀 Happy coding Naveen",
      }

      dashboard.section.footer.opts.hl = "DashboardFooter"

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          once = true,
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      -- =========================
      -- ⚙️ SETUP
      -- =========================
      alpha.setup(dashboard.opts)

      -- =========================
      -- 🎨 COLORS (PURPLE THEME)
      -- =========================
      vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#cba6f7" }) -- purple
      vim.api.nvim_set_hl(0, "DashboardCenter", { fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "#6c7086" })

      -- =========================
      -- 🔁 FIX RESET AFTER THEME LOAD
      -- =========================
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#cba6f7" })
          vim.api.nvim_set_hl(0, "DashboardCenter", { fg = "#ffffff" })
          vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "#6c7086" })
        end,
      })
    end,
  },
}
