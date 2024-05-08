-- Lil plugins that don't warrant their own files
-- TODO move these into more appropriate files

return {
  -- {
  --   "ellisonleao/gruvbox.nvim",
  --   priority = 1000,
  --   config = function()
  --     require("gruvbox").setup()
  --     vim.cmd.colorscheme("gruvbox")
  --   end,
  -- },
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
        options = { theme = "gruvbox", globalstatus = true },
      })
    end,
  },
  { "Theyashsawarkar/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons", opts = {} },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  {
    "nanotee/zoxide.vim",
    dependencies = {
      "junegunn/fzf",
      "junegunn/fzf.vim",
    },
    config = function()
      vim.keymap.set("n", "<leader>fz", "<Cmd>Zi<CR>", { desc = "Search with zoxide", silent = true })
    end,
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end,
  },
}
