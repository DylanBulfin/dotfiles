return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      -- Timeout before showing popup
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      defaults = {
        mode = { "n", "v" },
        -- Need to manually define group names or it defaults to `+prefix`
        -- Need to populate each because if one is unpopulated when this is run, config will be overwritten
        -- Probably a better way to do it but if it ain't broke
        ["g"] = { name = "+goto", ["🚫"] = "which_key_ignore" },
        ["]"] = { name = "+next", ["🚫"] = "which_key_ignore" },
        ["["] = { name = "+prev", ["🚫"] = "which_key_ignore" },
        ["z"] = { name = "+fold", ["🚫"] = "which_key_ignore" },
        ["<leader>"] = { name = "+leader", ["🚫"] = "which_key_ignore" },
        ["<leader>c"] = { name = "+code", ["🚫"] = "which_key_ignore" },
        ["<leader>f"] = { name = "+file/find", ["🚫"] = "which_key_ignore" },
        ["<leader>r"] = { name = "+rename", ["🚫"] = "which_key_ignore" },
        ["<leader>b"] = { name = "+buffers", ["🚫"] = "which_key_ignore" },
        ["<leader>x"] = { name = "+diagnostics", ["🚫"] = "which_key_ignore" },
        ["<leader>t"] = { name = "+toggle", ["🚫"] = "which_key_ignore" },
      },
      triggers_blacklist = {
        -- Disable popup for visual char mode
        n = { "v" },
      },
    },
    config = function(_, opts)
      local whichkey = require("which-key")
      whichkey.setup(opts)
      -- Important to register default groups mapped above
      whichkey.register(opts.defaults)
    end,
  },
}
