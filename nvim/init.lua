vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

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
  eol = "↴",
  tab = "▎_",
  trail = "•",
  extends = "❯",
  precedes = "❮",
  nbsp = "",
}

-- Misc keybindings I like
vim.keymap.set("n", "<leader>[", "<Cmd>bprev<CR>", { desc = "Previous buffer", silent = true })
vim.keymap.set("n", "<leader>]", "<Cmd>bnext<CR>", { desc = "Next buffer", silent = true })

vim.keymap.set("n", "<leader>N", "<Cmd>bprev<CR>", { desc = "Previous buffer", silent = true })
vim.keymap.set("n", "<leader>n", "<Cmd>bnext<CR>", { desc = "Next buffer", silent = true })

vim.keymap.set("v", "<leader>y", function()
  vim.cmd.normal('"+y')
end, { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>yy", function()
  vim.cmd.normal('"+' .. vim.v.count .. "yy")
end, { desc = "Yank to system clipboard" })

vim.keymap.set("n", "<leader>p", function()
  vim.cmd.normal('"+p')
end, { desc = "Paste from system clipboard" })

vim.keymap.set("n", "<leader>P", function()
  vim.cmd.normal('"+P')
end, { desc = "Paste from system clipboard" })

require("lazy").setup("plugins")
