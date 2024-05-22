local vscode = require("vscode-neovim")

vim.notify = vscode.notify -- send notification to VSCode

local lazypath = vim.fn.stdpath("data") .. "/lazy/vscode/lazy.nvim"
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

require("lazy").setup({
  root = vim.fn.stdpath("data") .. "/lazy/vscode",
  lockfile = vim.fn.stdpath("data") .. "/lazy/vscode/lazy.lock",
  state = vim.fn.stdpath("data") .. "/lazy/vscode/state.json",
  spec = {
    { import = "vscode.plugins" },
  },
  checker = {
    enabled = true,
    notify = true,
  },
})

local call = function(method)
  return function()
    vscode.call(method)
  end
end

vim.keymap.set("n", "<CR>", call("editor.action.smartSelect.expand"))
vim.keymap.set("v", "<CR>", call("editor.action.smartSelect.expand"))

vim.keymap.set("n", "<S-CR>", call("editor.action.smartSelect.shrink"))
vim.keymap.set("v", "<S-CR>", call("editor.action.smartSelect.shrink"))

vim.keymap.set("n", "gd", call("editor.action.revealDefinition"))
vim.keymap.set("v", "gd", call("editor.action.revealDefinition"))

vim.keymap.set("n", "gg", call("cursorTop"))
vim.keymap.set("v", "gg", call("cursorTop"))

vim.keymap.set("n", "gi", call("editor.action.goToImplementation"))
vim.keymap.set("v", "gi", call("editor.action.goToImplementation"))

vim.keymap.set("n", "gr", call("editor.action.goToReferences"))
vim.keymap.set("v", "gr", call("editor.action.goToReferences"))

vim.keymap.set("n", "zac", call("editor.foldAll"))
vim.keymap.set("v", "zac", call("editor.foldAll"))

vim.keymap.set("n", "zae", call("editor.unfoldAll"))
vim.keymap.set("v", "zae", call("editor.unfoldAll"))

vim.keymap.set("n", "zo", call("editor.foldAllExcept"))
vim.keymap.set("v", "zo", call("editor.foldAllExcept"))

vim.keymap.set("n", "zc", call("editor.fold"))
vim.keymap.set("v", "zc", call("editor.fold"))

vim.keymap.set("n", "ze", call("editor.unfold"))
vim.keymap.set("v", "ze", call("editor.unfold"))

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
