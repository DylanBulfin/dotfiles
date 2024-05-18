vim.g.mapleader = " " -- Space as leader
vim.g.maplocalleader = "\\"

if vim.g.vscode then
  require("vscode")
  return
end

-- Lazy setup, leave alone
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set options
local opt = vim.opt
opt.hidden = true -- probably don't need to set this manually but doing it anyway
opt.number = true
opt.relativenumber = true
opt.expandtab = true
opt.cursorline = true
opt.confirm = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.smartcase = true
opt.smartindent = true
opt.splitright = true
opt.splitbelow = true
opt.list = true
opt.virtualedit = "block"
opt.wrap = true
opt.signcolumn = "no"
opt.ignorecase = true
opt.laststatus = 3
opt.showmode = false
opt.background = "dark"
vim.opt.listchars = {
  space = "⋅",
  -- eol = "↴",
  tab = "▎_",
  trail = "•",
  extends = "❯",
  precedes = "❮",
  nbsp = "",
}

-- Misc keybindings I like
-- Buffer management, like to have options
vim.keymap.set("n", "<leader>[", "<Cmd>bprev<CR>", { desc = "Previous buffer", silent = true })
vim.keymap.set("n", "<leader>]", "<Cmd>bnext<CR>", { desc = "Next buffer", silent = true })
vim.keymap.set("n", "<leader>N", "<Cmd>bprev<CR>", { desc = "Previous buffer", silent = true })
vim.keymap.set("n", "<leader>n", "<Cmd>bnext<CR>", { desc = "Next buffer", silent = true })
vim.keymap.set("n", "gp", "<Cmd>bprev<CR>", { desc = "Previous buffer", silent = true })
vim.keymap.set("n", "gn", "<Cmd>bnext<CR>", { desc = "Next buffer", silent = true })

vim.keymap.set("n", "<leader>bd", "<Cmd>bd<CR>", { desc = "Close current buffer", silent = true })
vim.keymap.set("n", "<leader>bs", "<Cmd>w<CR>", { desc = "Save buffer", silent = true })

-- Jump to start/end of line, easier to remember than 0 and $
vim.keymap.set({ "n", "v" }, "gM", "0", { desc = "Go to start of line" })
vim.keymap.set({ "n", "v" }, "gm", "^", { desc = "Go to start of line (non-whitespace)" })
vim.keymap.set({ "n", "v" }, "gi", "$", { desc = "Go to end of line" })
vim.keymap.set({ "n", "v" }, "gI", "$", { desc = "Go to end of line" })

-- Copy paste from system clipboard
vim.keymap.set("v", "<leader>y", function()
  vim.cmd.normal('"+y')
end, { desc = "Yank to system clipboard" })

-- Basically acts as an alias, <space>y can be used in place of "+y, including with motions/textobjectss
vim.keymap.set("n", "<leader>y", function()
  return '"+y'
end, { expr = true, desc = "Yank to system clipboard" })

vim.keymap.set("n", "<leader>p", function()
  vim.cmd.normal('"+p')
end, { desc = "Paste from system clipboard" })

vim.keymap.set("n", "<leader>P", function()
  vim.cmd.normal('"+P')
end, { desc = "Paste from system clipboard" })

local to_one_window = function()
  for key, value in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    -- Only keep the first window, which is the top left one by default
    if key ~= 1 then
      if vim.api.nvim_win_is_valid(value) then
        vim.api.nvim_win_close(value, true)
      end
    end
  end
end

-- Add ctrl-backspace mapping in insert mode
vim.keymap.set("i", "<C-BS>", "<C-w>", { desc = "Delete previous word" })
vim.keymap.set("c", "<C-BS>", "<C-w>", { desc = "Delete previous word" })

-- Close all except main window on current tabpage (insert mode mapping for telescope)
vim.keymap.set({ "n", "i" }, "<C-w>a", to_one_window, { noremap = false, desc = "Close all but main window" })
vim.keymap.set("n", "<leader>wa", to_one_window, { noremap = false, desc = "Close all but main window" })

-- Quit all windows and nvim (non-forced)
vim.keymap.set("n", "<leader>qq", "<Cmd>qa<CR>", { desc = "Quit Neovim" })

-- Alias <leader>w to <C-w> bc I think it's more ergonomic (breaks which-key tho)
vim.keymap.set("n", "<leader>w", "<C-w>", { desc = "+windows" })

-- In terminal mode let <Esc> do what it's supposed to
vim.keymap.set("t", "<Esc>", function()
  return "<C-\\><C-n>"
end, { expr = true, desc = "Exit terminal mode" })

vim.keymap.set({ "n", "v", "i" }, "<C-i>", function()
  vim.cmd.normal("zz")
end, { desc = "Center screen" })

-- Go to indent in insert mode
vim.keymap.set("i", "<C-e>", "<Esc>cc", { desc = "Clear line" })

-- Select whole buffer
vim.keymap.set({ "n", "v" }, "<leader>a", "ggVG", { desc = "Select entire buffer" })

require("keyboard").colemak()

vim.api.nvim_create_user_command("Colemak", function()
  require("keyboard").colemak()
end, {
  desc = "Set keybindings to Colemak",
})

vim.api.nvim_create_user_command("Qwerty", function()
  require("keyboard").qwerty()
end, {
  desc = "Set keybindings to Qwerty",
})

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  checker = {
    enabled = true,
    notify = true,
  },
})
