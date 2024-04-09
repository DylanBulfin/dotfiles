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
      vim.keymap.set("n", "<leader>cs", "<Cmd>Copilot status<CR>", { desc = "Copilot status" })
      vim.keymap.set("n", "<leader>ce", "<Cmd>Copilot enable<CR>", { desc = "Copilot enable" })
      vim.keymap.set("n", "<leader>cd", "<Cmd>Copilot disable<CR>", { desc = "Copilot disable" })
      require("copilot").setup(opts)
    end,
  },
}
