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
    "echasnovski/mini.sessions",
    config = function()
      require("mini.sessions").setup({
        directory = "",
        file = ".session",
        autoread = true,
        autowrite = true,
        -- hooks = {
        --   pre = {
        --     write = function()
        --       vim.cmd("<Cmd>Neotree close<CR>")
        --       if require("trouble").is_open("diagnostics") then
        --         vim.cmd("<Cmd>Trouble diagnostics close<CR>")
        --       end
        --       vim.cmd("<Cmd>mksession .session<CR>")
        --     end,
        --   },
        -- },
      })
    end,
  },
}
