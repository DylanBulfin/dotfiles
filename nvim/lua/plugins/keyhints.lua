return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300

      -- Initialize which-key groups
      vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Float diagnostics" })
    end,
    opts = {
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto", ["🚫"] = "which_key_ignore" },
        ["]"] = { name = "+next", ["🚫"] = "which_key_ignore" },
        ["["] = { name = "+prev", ["🚫"] = "which_key_ignore" },
        ["<leader>c"] = { name = "+code", ["🚫"] = "which_key_ignore" },
        ["<leader>f"] = { name = "+file/find", ["🚫"] = "which_key_ignore" },
        ["<leader>r"] = { name = "+rename", ["🚫"] = "which_key_ignore" },
        ["<leader>w"] = { name = "+workspaces", ["🚫"] = "which_key_ignore" },
      },
    },
    config = function(_, opts)
      local whichkey = require("which-key")
      whichkey.setup(opts)
      whichkey.register(opts.defaults)
    end,
  },
}
