vim.g.neotree_enabled = false

vim.keymap.set("n", "<leader>ft", function()
  if vim.g.neotree_enabled then
    vim.g.neotree_enabled = false
    vim.cmd("Neotree close")
  else
    vim.g.neotree_enabled = true
    vim.cmd("Neotree")
  end
end, { desc = "Toggle file tree" })

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
  },
}
