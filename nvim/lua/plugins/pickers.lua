return {
  {
    "nvim-telescope/telescope.nvim",
    version = false,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --lfrefix build",
      },
      { "gbrlsnchs/telescope-lsp-handlers.nvim" },
      { "luc-tielen/telescope_hoogle" },
    },
    config = function()
      require("telescope").setup({
        pickers = {
          find_files = {
            theme = "dropdown",
          },
        },
      })
      -- Base telescope picker keymaps
      local builtin = require("telescope.builtin")
      vim.keymap.set({ "n", "v" }, "<leader>ff", builtin.find_files, { desc = "Find Files" })
      vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find in workspace" })
      vim.keymap.set({ "n", "v" }, "<leader>bb", builtin.buffers, { desc = "List buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "View help tags" })
      local telescope = require("telescope")
      telescope.load_extension("fzf")
      telescope.load_extension("lsp_handlers")
      telescope.load_extension("hoogle")
      -- Plugin-specific keymaps
      vim.keymap.set(
        "n",
        "<leader>lh",
        "<Cmd>Telescope hoogle<CR>",
        { silent = true, desc = "Start live hoogle search" }
      )
    end,
  },
}
