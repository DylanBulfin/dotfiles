return {
  {
    "nvim-telescope/telescope.nvim",
    version = false,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      { "gbrlsnchs/telescope-lsp-handlers.nvim" },
      { "luc-tielen/telescope_hoogle" },
      { "nvim-telescope/telescope-ui-select.nvim" },
      {
        "danielfalk/smart-open.nvim",
        branch = "0.2.x",
        config = function() end,
        dependencies = {
          "kkharji/sqlite.lua",
          { "nvim-telescope/telescope-fzy-native.nvim" },
        },
      },
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
      -- vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Find Files" })
      vim.keymap.set("n", "<leader><leader>", function()
        require("telescope").extensions.smart_open.smart_open()
      end, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>ff", builtin.live_grep, { desc = "Find in workspace" })
      vim.keymap.set({ "n", "v" }, "<leader>bb", builtin.buffers, { desc = "List buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "View help tags" })
      vim.keymap.set("n", "<leader>fp", builtin.commands, { desc = "View commands" })
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
      vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "View document symbols" })
      vim.keymap.set("n", "<leader>fr", builtin.grep_string, { desc = "View symbol references" })
      vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "View quickfix list" })
      vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "View commands" })
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("lsp_handlers")
      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("smart_open")
    end,
  },
}
