local M = {}

function M.configure()
  vim.keymap.set({ "n", "v" }, "n", "j", { desc = "Down" })
  vim.keymap.set({ "n", "v" }, "e", "k", { desc = "Up" })

  vim.keymap.set({ "n", "v" }, "j", "e", { desc = "Next end of word" })
end

return M
