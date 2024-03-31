return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      { "kevinhwang91/promise-async" },
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require("statuscol.builtin")
          -- Fix bg colors for sign/fold columns
          vim.api.nvim_set_hl(0, "SignColumn", { bg = "#282828" })
          vim.api.nvim_set_hl(0, "FoldColumn", { bg = "#282828" })

          -- Add icons for statuscol diagnostics
          vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
          vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
          vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
          vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

          -- Disable inline diagnostics via virtual_text setting
          vim.keymap.set("n", "<leader>xi", function()
            local curr = vim.diagnostic.config().virtual_text
            if curr then
              vim.diagnostic.config({ virtual_text = false })
            else
              vim.diagnostic.config({ virtual_text = true })
            end
          end, { desc = "Toggle inline diagnostics" })

          -- Force highest severity to display over others
          vim.diagnostic.config({ severity_sort = true })

          require("statuscol").setup({
            ft_ignore = { "trouble" },
            segments = {
              {
                sign = { name = { "Diagnostic" }, maxwidth = 1 },
                click = "v:lua.ScSa",
              },
              {
                text = { builtin.foldfunc, " " },
                condition = { builtin.not_empty, true, builtin.not_empty },
                click = "v:lua.ScFa",
              },
              { text = { "%s" }, click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            },
          })
        end,
      },
    },
    config = function()
      -- Required setup for ufo
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

      require("ufo").setup()
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {
      icons = false,
      use_diagnostic_signs = true, -- Makes sure trouble is in sync with other diagnostics sign users
    },
    config = function()
      vim.keymap.set("n", "<leader>xx", function()
        require("trouble").toggle()
      end, { desc = "Toggle Trouble" })
      vim.keymap.set("n", "<leader>xw", function()
        require("trouble").toggle("workspace_diagnostics")
      end, { desc = "Toggle workspace diagnostics" })
      vim.keymap.set("n", "<leader>xd", function()
        require("trouble").toggle("document_diagnostics")
      end, { desc = "Toggle document diagnostics" })
      vim.keymap.set("n", "<leader>xq", function()
        require("trouble").toggle("quickfix")
      end, { desc = "Toggle quickfix" })
    end,
  },
}
