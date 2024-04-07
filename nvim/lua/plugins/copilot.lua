return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    lazy = true,
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        auto_trigger = true,
        debouce = 100,
        keymap = {
          accept = "<Right>",
          next = "<Down>",
          prev = "<Up>",
        },
      },
      server_opts_override = {
        settings = {
          advanced = {
            inlineSuggestCount = 3,
          },
        },
      },
    },
    config = function(_, opts)
      require("copilot").setup(opts)
    end,
  },
}
