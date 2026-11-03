return {
  {
    "ajbucci/ipynb.nvim",
    event = { "BufReadCmd *.ipynb", "BufWriteCmd *.ipynb", "VeryLazy" },

    dependencies = {
      "neovim/nvim-lspconfig",
      "folke/snacks.nvim",
    },

    opts = {
      float = {
        border = "rounded",
        overlay = true,
        show_line_numbers = false,
      },
      border_hints = {
        enabled = true,
        show_on_hover = true,
        show_on_edit = true,
      },
      highlights = {
        border_active = "SpecialChar",
        border_hover = "Special",
      },
    },

    config = function(_, opts)
      -- Handle empty (0-byte) .ipynb files gracefully
      local ipynb_io = require("ipynb.io")
      local orig_read = ipynb_io.read_ipynb
      ipynb_io.read_ipynb = function(path)
        if vim.fn.filereadable(path) == 1 and vim.fn.getfsize(path) <= 0 then
          return ipynb_io.create_empty_notebook()
        end
        local content = vim.fn.readfile(path)
        if vim.trim(table.concat(content, "\n")) == "" then
          return ipynb_io.create_empty_notebook()
        end
        return orig_read(path)
      end

      -- Ensure open_output_float always resolves the correct cell index
      local ipynb_output = require("ipynb.output")
      local orig_open_output = ipynb_output.open_output_float
      ipynb_output.open_output_float = function(state, cell_idx)
        if not cell_idx then
          if state.edit_state and state.edit_state.cell_idx then
            cell_idx = state.edit_state.cell_idx
          else
            local cursor_line = vim.api.nvim_win_get_cursor(0)[1] - 1
            cell_idx = require("ipynb.cells").get_cell_at_line(state, cursor_line)
          end
        end
        return orig_open_output(state, cell_idx)
      end

      -- Autocmd to guarantee ]] and [[ and <leader>ko never get hijacked by Snacks.words or LazyVim LSP
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("IpynbLspKeymapGuard", { clear = true }),
        callback = function(args)
          local buf = args.buf
          local state_mod = require("ipynb.state")
          local state = state_mod.get_from_edit_buf(buf)
          if state and state.edit_state and state.edit_state.buf == buf then
            local map_opts = { buffer = buf, silent = true, nowait = true }

            -- Cell navigation inside edit mode
            vim.keymap.set("n", "]]", function()
              require("ipynb.edit").edit_next_cell(state)
            end, vim.tbl_extend("force", map_opts, { desc = "Edit next cell" }))

            vim.keymap.set("n", "[[", function()
              require("ipynb.edit").edit_prev_cell(state)
            end, vim.tbl_extend("force", map_opts, { desc = "Edit previous cell" }))

            vim.keymap.set("n", "<C-j>", function()
              require("ipynb.edit").edit_next_cell(state)
            end, vim.tbl_extend("force", map_opts, { desc = "Edit next cell" }))

            vim.keymap.set("n", "<C-k>", function()
              require("ipynb.edit").edit_prev_cell(state)
            end, vim.tbl_extend("force", map_opts, { desc = "Edit previous cell" }))

            -- Correct output opening for current cell
            vim.keymap.set("n", "<leader>ko", function()
              require("ipynb.output").open_output_float(state, state.edit_state.cell_idx)
            end, vim.tbl_extend("force", map_opts, { desc = "Output open" }))

            -- Cell delete from edit mode
            vim.keymap.set("n", "<leader>kd", function()
              local edit = state.edit_state
              if edit then
                require("ipynb.edit").close(state)
                require("ipynb.keymaps").cut_cell(state)
              end
            end, vim.tbl_extend("force", map_opts, { desc = "Cell cut / delete" }))
          end
        end,
      })

      require("ipynb").setup(opts)
    end,
  },
}
