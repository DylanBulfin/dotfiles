return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup()
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = "catppuccin", globalstatus = true },
      })
    end,
  },
  { "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons", opts = {} },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
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
}
