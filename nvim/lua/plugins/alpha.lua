return {
  "goolord/alpha-nvim",
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
      dashboard.button("s", "  Restore Session", ":SessionRestore <CR>"),
      dashboard.button("x", "  Lazy Extras", ":LazyExtras <CR>"),
      dashboard.button("l", "󰒲  Lazy", ":Lazy <CR>"),
      dashboard.button("q", "  Quit", ":qa<CR>"),
    }

    -- optional styling
    dashboard.section.buttons.opts.hl = "DashboardCenter"

    -- =========================
    -- 📝 FOOTER
    -- =========================
    dashboard.section.footer.val = {
      "🚀 Happy coding Naveen"
    }

    dashboard.section.footer.opts.hl = "DashboardFooter"

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
}
