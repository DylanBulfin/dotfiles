local general = vim.api.nvim_create_augroup("General", { clear = true })
-- By default nvim will try to continue comments on next line, very annoying to me
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  group = general,
  desc = "Disable newline comment",
})

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
  pattern = { "cs", "haskell", "javascript", "typescript", "typescriptreact" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
  group = general,
  desc = "Set tab width to 4 for certain languages",
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
      require("mini.surround").setup()
    end,
  },
  {
    "echasnovski/mini.ai",
    version = false,
    opts = {
      mappings = {
        around = "a",
        inside = "u",

        around_next = "an",
        inside_next = "un",
        around_last = "al",
        inside_last = "ul",
      },
      custom_textobjects = {
        u = function(mode)
          -- count whitespace characters at beginning of current line
          local function get_indent(line)
            local _, indent = string.find(line, "^%s*")
            return indent
          end

          local region_start = nil
          local region_end = nil

          local start_lnum = vim.fn.line(".") -- line of cursor
          local start_indent = get_indent(vim.fn.getline(start_lnum))

          local last_lnum = vim.fn.line("$") -- last line of file

          local curr_lnum = start_lnum - 1

          -- Seach backwards for start of region
          while true do
            if curr_lnum <= 1 then -- start of file
              region_start = 1
              break
            elseif get_indent(vim.fn.getline(curr_lnum)) < start_indent then -- reached start of region
              region_start = curr_lnum + 1
              break
            else
              curr_lnum = curr_lnum - 1
            end
          end

          curr_lnum = start_lnum + 1

          while true do
            if curr_lnum >= last_lnum then -- end of file
              region_end = last_lnum
              break
            elseif get_indent(vim.fn.getline(curr_lnum)) < start_indent then -- reached end of region
              region_end = curr_lnum - 1
              break
            else
              curr_lnum = curr_lnum + 1
            end
          end

          -- Should never happen
          if (region_start == nil) or (region_end == nil) then
            vim.notify("Error calculating region")
            return
          end

          local from, to
          if mode == "i" then -- inside mode used
            from = {
              line = region_start,
              col = 1,
            }
            to = {
              line = region_end,
              col = math.max(vim.fn.getline(region_end):len(), 1), -- make sure col is not 0
            }
          else -- around mode used
            local end_lnum = math.min(region_end + 1, last_lnum)
            from = {
              line = math.max(region_start - 1, 1),
              col = 1,
            }
            to = {
              line = end_lnum,
              col = math.max(vim.fn.getline(end_lnum):len(), 1),
            }
          end

          return { from = from, to = to }
        end,
      },
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
