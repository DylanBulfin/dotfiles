local general = vim.api.nvim_create_augroup("General", { clear = true })
-- By default nvim will try to continue comments on next line, very annoying to me
-- vim.api.nvim_create_autocmd("BufEnter", {
--   callback = function()
--     vim.opt.formatoptions:remove({ "c", "r", "o" })
--   end,
--   group = general,
--   desc = "Disable newline comment",
-- })

-- Backup current state of disable_autoformat, then set it to true
-- It is incredibly irritating when autosave also formats but I don't want to disable entirely
vim.api.nvim_create_autocmd("User", {
  pattern = "AutoSaveWritePre",
  callback = function()
    vim.g.disable_autoformat_prev = vim.g.disable_autoformat
    vim.g.disable_autoformat = true
  end,
  group = general,
  desc = "Disable format during autosave",
})
-- Restore former state
vim.api.nvim_create_autocmd("User", {
  pattern = "AutoSaveWritePost",
  callback = function()
    vim.g.disable_autoformat = vim.g.disable_autoformat_prev
  end,
  group = general,
  desc = "Disable format during autosave",
})

-- Set tabstop to 4 for certain filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "cs", "haskell", "javascript", "typescript", "typescriptreact", "sh" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
  group = general,
  desc = "Set tab width to 4 for certain languages",
})

-- Set tabstop to 4 for certain filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gdscript", "gd", "godot", "py", "python" },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 0
  end,
  group = general,
  desc = "Disable spaces for certain file types",
})

vim.g.disable_autoformat = false
vim.keymap.set("n", "<leader>tf", function()
  if vim.g.disable_autoformat then
    vim.g.disable_autoformat = false
  else
    vim.g.disable_autoformat = true
  end
end, { desc = "Toggle format-on-save" })

return {
  {
    "stevearc/conform.nvim",
    config = function()
      local conform = require("conform")
      conform.setup({
        -- Mostly defaults work
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "black" },
          godot = { "gdformat" },
          gdscript = { "gdformat" },
        },
        -- When function returns nil format on save is disabled
        format_on_save = function()
          if vim.g.disable_autoformat then
            return
          end
          return { timeout_ms = 500, lsp_fallback = true }
        end,
        formatters = {
          stylua = {
            prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
          },
        },
      })
    end,
  },
  {
    "echasnovski/mini.surround",
    version = false,
    config = function()
      require("mini.surround").setup({
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          update_n_lines = "", -- Update `n_lines`
          suffix_last = "", -- Suffix to search with "prev" method
          suffix_next = "", -- Suffix to search with "next" method
        },

        -- Number of lines within which surrounding is searched
        n_lines = 50,
      })
    end,
  },
  {
    "echasnovski/mini.ai",
    version = false,
    opts = {
      mappings = {
        around = "a",
        inside = "i",

        around_next = "an",
        inside_next = "in",
        around_last = "al",
        inside_last = "il",
      },
      n_lines = 200,
    },
    config = function(_, opts)
      require("mini.ai").setup(opts)
    end,
  },
  {
    "okuuva/auto-save.nvim",
    -- AutoSaveWritePost
    opts = {
      condition = function(buf)
        local fn = vim.fn
        local utils = require("auto-save.utils.data")

        -- Lua autoformat is annoying when doing nvim dev, telescope prompt autosave just creates irritating messages
        if utils.not_in(fn.getbufvar(buf, "&filetype"), { "lua", "TelescopePrompt" }) then
          return true -- met condition(s), can save
        end
        return false -- can't save
      end,
    },
    config = function(_, opts)
      require("auto-save").setup(opts)
      vim.keymap.set("n", "<leader>ts", "<Cmd>ASToggle<CR>", { desc = "Toggle autosave" })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local ap = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")
      ap.setup()

      ap.add_rule(Rule("<", ">", "rust"):with_pair(cond.before_regex("%a+")):with_move(function(opts)
        return opts.char == ">"
      end))
      ap.add_rule(Rule("|", "|", "rust"):with_pair(cond.before_text("(")):with_move(function(opts)
        return opts.char == "|"
      end))
    end,
  },
}
