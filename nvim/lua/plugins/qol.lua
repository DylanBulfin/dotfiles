return {
  {
    "smoka7/hop.nvim",
    config = function()
      require("hop").setup({
        keys = "arsgmeiqwfpbluy;zxcdvkhtn",
      })
      vim.keymap.set({ "n", "x", "o" }, "sn", "<Cmd>HopWord<CR>")
      vim.keymap.set({ "n", "x", "o" }, "sc", "<Cmd>HopChar2<CR>")
      vim.keymap.set({ "n", "x", "o" }, "st", "<Cmd>HopChar1<CR>")
    end,
  },
  {
    "willothy/flatten.nvim",
    config = true,
    -- or pass configuration with
    -- opts = {  }
    -- Ensure that it runs first to minimize delay when opening file from terminal
    lazy = false,
    priority = 1001,
  },
}
