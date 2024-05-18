local M = {}

function M.colemak()
  vim.keymap.set({ "n", "v", "o" }, "m", "h", { desc = "Left" })
  vim.keymap.set({ "n", "v", "o" }, "n", "j", { desc = "Down" })
  vim.keymap.set({ "n", "v", "o" }, "e", "k", { desc = "Up" })
  vim.keymap.set({ "n", "v", "o" }, "i", "l", { desc = "Right" })

  vim.keymap.set({ "n", "v", "o" }, "j", "e", { desc = "Next end of word" })
  vim.keymap.set({ "n", "v" }, "k", "n", { desc = "Next match" })
  vim.keymap.set({ "n", "v" }, "K", "N", { desc = "Previous match" })
  vim.keymap.set({ "n", "v" }, "u", "i", { desc = "Insert mode" })
  vim.keymap.set({ "o" }, "u", "i", { desc = "Inside" })
  vim.keymap.set({ "n", "v" }, "U", "I", { desc = "Insert mode at beginning of line" })
  vim.keymap.set({ "n", "v" }, "l", "u", { desc = "Undo" })
  vim.keymap.set({ "n", "v" }, "L", "<C-r>", { desc = "Redo" })

  vim.keymap.set("n", "<C-w>m", "<C-w>h", { desc = "Move to left window" })
  vim.keymap.set("n", "<C-w>n", "<C-w>j", { desc = "Move to lower window" })
  vim.keymap.set("n", "<C-w>e", "<C-w>k", { desc = "Move to upper window" })
  vim.keymap.set("n", "<C-w>i", "<C-w>l", { desc = "Move to right window" })
  vim.keymap.set("n", "<leader>wm", "<C-w>h", { desc = "Move to left window" })
  vim.keymap.set("n", "<leader>wn", "<C-w>j", { desc = "Move to lower window" })
  vim.keymap.set("n", "<leader>we", "<C-w>k", { desc = "Move to upper window" })
  vim.keymap.set("n", "<leader>wi", "<C-w>l", { desc = "Move to right window" })
end

function M.qwerty()
  vim.keymap.set({ "n", "v", "o" }, "h", "h", { desc = "Left" })
  vim.keymap.set({ "n", "v", "o" }, "j", "j", { desc = "Down" })
  vim.keymap.set({ "n", "v", "o" }, "k", "k", { desc = "Up" })
  vim.keymap.set({ "n", "v", "o" }, "l", "l", { desc = "Right" })

  vim.keymap.set({ "n", "v", "o" }, "e", "e", { desc = "Next end of word" })
  vim.keymap.set({ "n", "v" }, "n", "n", { desc = "Next match" })
  vim.keymap.set({ "n", "v" }, "N", "N", { desc = "Previous match" })
  vim.keymap.set({ "n", "v" }, "i", "i", { desc = "Insert mode" })
  vim.keymap.set({ "o" }, "i", "i", { desc = "Inside" })
  vim.keymap.set({ "n", "v" }, "I", "I", { desc = "Insert mode at beginning of line" })
  vim.keymap.set({ "n", "v" }, "u", "u", { desc = "Undo" })
  vim.keymap.set({ "n", "v" }, "U", "<C-r>", { desc = "Redo" })

  vim.keymap.set("n", "<C-w>h", "<C-w>h", { desc = "Move to left window" })
  vim.keymap.set("n", "<C-w>j", "<C-w>j", { desc = "Move to lower window" })
  vim.keymap.set("n", "<C-w>k", "<C-w>k", { desc = "Move to upper window" })
  vim.keymap.set("n", "<C-w>l", "<C-w>l", { desc = "Move to right window" })
  vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Move to left window" })
  vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Move to lower window" })
  vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Move to upper window" })
  vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Move to right window" })
end

return M
