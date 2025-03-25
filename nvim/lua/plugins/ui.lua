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
  {
    "romgrk/barbar.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
      "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    config = function()
      vim.g.barbar_auto_setup = false

      require("barbar").setup({
        hide = { extensions = false },
        letters = "arstneiocdhxzgmvkbjplfuwyq;ARSTNEIOCDHXZGMVKBJPLFUWYQ",
      })

      -- Move to previous/next
      -- vim.keymap.set("n", "<leader>N", "<Cmd>BufferPrevious<CR>", { desc = "Previous Buffer" })
      -- vim.keymap.set("n", "<leader>n", "<Cmd>BufferNext<CR>", { desc = "Next Buffer" })
      -- Goto buffer in position...
      vim.keymap.set("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", { desc = "Goto Buffer 1" })
      vim.keymap.set("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", { desc = "Goto Buffer 2" })
      vim.keymap.set("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", { desc = "Goto Buffer 3" })
      vim.keymap.set("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", { desc = "Goto Buffer 4" })
      vim.keymap.set("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", { desc = "Goto Buffer 5" })
      vim.keymap.set("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", { desc = "Goto Buffer 6" })
      vim.keymap.set("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", { desc = "Goto Buffer 7" })
      vim.keymap.set("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", { desc = "Goto Buffer 8" })
      vim.keymap.set("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", { desc = "Goto Buffer 9" })
      vim.keymap.set("n", "<A-0>", "<Cmd>BufferLast<CR>", { desc = "Goto Last Buffer" })
      -- Pin/unpin buffer
      vim.keymap.set("n", "<leader>bp", "<Cmd>BufferPin<CR>", { desc = "Pin Buffer" })
      -- Pick Buffer
      vim.keymap.set("n", "<leader>pf", "<Cmd>BufferPick<CR>", { desc = "Buffer Pick Mode" })
      -- Buffer Management
      vim.keymap.set("n", "<leader>bc", "<Cmd>BufferClose<CR>", { desc = "Close Buffer" })
      vim.keymap.set("n", "<leader>ba", "<Cmd>BufferCloseAllButPinned<CR>", { desc = "Close Buffer" })
      vim.keymap.set("n", "<leader>bo", "<Cmd>BufferCloseAllButCurrentOrPinned<CR>", { desc = "Close Buffer" })
    end,
  },

  -- { "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons", opts = {} },
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
