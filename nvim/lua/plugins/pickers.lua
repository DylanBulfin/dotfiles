return {
  {
    "nvim-telescope/telescope.nvim",
    version = false,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      },
      { "gbrlsnchs/telescope-lsp-handlers.nvim" },
    },
    config = function()
      require("telescope").setup({
        pickers = {
          find_files = {
            theme = "dropdown",
          },
        },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set({ "n", "v" }, "<leader>ff", builtin.find_files, { desc = "Find Files" })
      vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find in workspace" })
      vim.keymap.set({ "n", "v" }, "<leader>fb", builtin.buffers, { desc = "List buffers" })
      vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "List buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "View help tags" })
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("lsp_handlers")
    end,
  },
}
