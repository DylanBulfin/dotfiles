return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      { "kevinhwang91/promise-async" },
      {
        "luukvbaal/statuscol.nvim",
        branch = "0.10",
        config = function()
          local builtin = require("statuscol.builtin")
          -- Fix bg colors for sign/fold columns
          -- vim.api.nvim_set_hl(0, "SignColumn", { bg = "#282828" })
          -- vim.api.nvim_set_hl(0, "FoldColumn", { bg = "#282828" })

          local sev = vim.diagnostic.severity

          -- Add icons for statuscol diagnostics
          -- Force highest severity to display over others
          vim.diagnostic.config({
            severity_sort = true,
            signs = {
              text = {
                [sev.WARN] = "",
                [sev.ERROR] = "",
                [sev.INFO] = "",
                [sev.HINT] = "",
              },
            },
          })

          -- Disable inline diagnostics via virtual_text setting
          vim.keymap.set("n", "<leader>xi", function()
            local curr = vim.diagnostic.config().virtual_text
            if curr then
              vim.diagnostic.config({ virtual_text = false })
            else
              vim.diagnostic.config({ virtual_text = true })
            end
          end, { desc = "Toggle inline diagnostics" })

          require("statuscol").setup({
            ft_ignore = { "trouble", "lazy", "neo-tree" },
            bt_ignore = { "nofile" },
            segments = {
              {
                sign = { namespace = { "diagnostic*", "todo*" }, maxwidth = 1 },
              },
              {
                text = { builtin.foldfunc, " " },
                condition = { builtin.not_empty, true, builtin.not_empty },
                click = "v:lua.ScFa",
              },
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
    branch = "dev",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      vim.keymap.set("n", "<leader>xx", function()
        require("trouble").toggle({ mode = "diagnostics" })
      end, { desc = "Toggle workspace Diagnostics" })
      vim.keymap.set("n", "<leader>xd", function()
        require("trouble").toggle({ mode = "diagnostics", filter = { buf = 0 } })
      end, { desc = "Toggle document diagnostics" })
      vim.keymap.set("n", "<leader>xq", function()
        require("trouble").toggle("qflist")
      end, { desc = "Toggle quickfix" })

      require("trouble").setup()
    end,
  },
}
