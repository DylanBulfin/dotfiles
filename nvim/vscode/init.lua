local plugins = {
	{
		"nvim-mini/mini.surround",
		opts = {
			mappings = { suffix_next = "", suffix_last = "" },
		},
	},
	{
		"chrisgrieser/nvim-spider",
		opts = {
			-- skipInsignificantPunctuation = false
		},
	},
	{
		"smoka7/hop.nvim",
		opts = {
			keys = "arsgmeiqwfpbluy;zxcdvkhtn",
		},
	},
}

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.virtualedit = "block"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    plugins,
  },
  checker = { enabled = false },
})

-- Key bindings
vim.keymap.set({ "n", "x", "o" }, "sn", "<Cmd>HopWord<CR>")
vim.keymap.set({ "n", "x", "o" }, "sc", "<Cmd>HopChar2<CR>")
vim.keymap.set({ "n", "x", "o" }, "st", "<Cmd>HopChar1<CR>")

vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>")
vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>")
vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>")

-- Copy paste from system clipboard
vim.keymap.set("v", "<leader>y", function()
	vim.cmd.normal('"+y')
end, { desc = "Yank to system clipboard" })

-- Basically acts as an alias, <space>y can be used in place of "*y, including with motions/textobjectss
vim.keymap.set("n", "<leader>y", function()
	return '"+y'
end, { expr = true, desc = "Yank to system clipboard" })

vim.keymap.set("n", "<leader>p", function()
	vim.cmd.normal('"+p')
end, { desc = "Paste from system clipboard" })

vim.keymap.set("n", "<leader>P", function()
	vim.cmd.normal('"+P')
end, { desc = "Paste from system clipboard" })


