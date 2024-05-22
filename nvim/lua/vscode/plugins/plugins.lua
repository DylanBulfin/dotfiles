return {
  {
    "echasnovski/mini.surround",
    version = false,
    config = function()
      require("mini.surround").setup()
    end,
  },
  -- {
  --   "nvim-treesitter/nvim-treesitter-textobjects",
  --   branch = "main",
  --   config = function()
  --     require("nvim-treesitter-textobjects")
  --     -- keymaps
  --     -- You can use the capture groups defined in `textobjects.scm`
  --     vim.keymap.set({ "x", "o" }, "af", function()
  --       require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
  --     end)
  --     vim.keymap.set({ "x", "o" }, "if", function()
  --       require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
  --     end)
  --     vim.keymap.set({ "x", "o" }, "ac", function()
  --       require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
  --     end)
  --     vim.keymap.set({ "x", "o" }, "ic", function()
  --       require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
  --     end)
  --   end,
  -- },
}
