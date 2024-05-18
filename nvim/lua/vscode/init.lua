local vscode = require("vscode-neovim")

vim.notify = vscode.notify -- send notification to VSCode

local call = function(method)
  return function()
    vscode.call(method)
  end
end

vim.keymap.set({ "n", "v" }, "<leader>w", "<C-w>")
vim.keymap.set({ "n", "v" }, "<leader>qq", call("workbench.action.quit"))
vim.keymap.set({ "n", "v" }, "<leader>ft", call("workbench.action.toggleSidebarVisibility"))
vim.keymap.set({ "n", "v" }, "<leader>bs", call("workbench.action.files.save"))
vim.keymap.set({ "n", "v" }, "<leader>bc", call("workbench.action.closeActiveEditor"))
vim.keymap.set({ "n", "v" }, "<leader><leader>", call("workbench.action.quickOpen"))
vim.keymap.set({ "n", "v" }, "<leader>fg", call("workbench.action.findInFiles"))
vim.keymap.set({ "n", "v" }, "<leader>fp", call("workbench.action.showCommands"))
vim.keymap.set({ "n", "v" }, "<leader>cc", call("workbench.panel.chat.view.copilot.focus"))
vim.keymap.set({ "n", "v" }, "<leader>ct", call("github.copilot.toggleCopilot"))

vim.keymap.set({ "n", "v" }, "<leader>vm", call("workbench.views.extensions.marketplace.focus"))
vim.keymap.set({ "n", "v" }, "<leader>ve", call("workbench.view.explorer"))
vim.keymap.set({ "n", "v" }, "<leader>vt", call("workbench.action.focusAuxiliaryBar"))

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
