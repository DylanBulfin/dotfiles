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
opt.ignorecase = true
opt.smartcase = true
opt.smartindent = true
opt.splitright = true
opt.splitbelow = true
opt.list = true
opt.virtualedit = "block"
opt.wrap = true
opt.laststatus = 3
opt.showmode = false
opt.background = "dark"
opt.listchars = {
  space = "⋅",
  -- eol = "↴",
  tab = "▎_",
  trail = "•",
  extends = "❯",
  precedes = "❮",
  nbsp = "",
}

vim.cmd.colorscheme("catppuccin")

