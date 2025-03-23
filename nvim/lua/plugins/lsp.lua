return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {},
        gdscript = {
          name = "godot",
          cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
        },
        rust_analyzer = {},
      },
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      for server, config in pairs(opts.servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        -- config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        config.capabilities = require("cmp_nvim_lsp").default_capabilities()
        lspconfig[server].setup(config)
      end
    end,
  },

  {
    "nvimdev/lspsaga.nvim",
    config = true,
    event = "LspAttach",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>l", group = "LSP" },
      { "<leader>fs", mode = { "n" }, "<CMD>Lspsaga finder<CR>", desc = "Finder" },
      { "<leader>ca", mode = { "n" }, "<CMD>Lspsaga code_action<CR>", desc = "Code Actions" },
      { "<leader>ld", mode = { "n" }, "<CMD>Lspsaga peek_definition<CR>", desc = "Peek Definition" },
      { "<leader>lD", mode = { "n" }, "<CMD>Lspsaga peek_type_definition<CR>", desc = "Peek Type Definition" },
      { "<leader>xn", mode = { "n" }, "<CMD>Lspsaga diagnostic_jump_next<CR>", desc = "Next Diagnostic" },
      { "<leader>xN", mode = { "n" }, "<CMD>Lspsaga diagnostic_jump_previous<CR>", desc = "Previous Diagnostic" },
      { "<leader>e", mode = { "n" }, "<CMD>Lspsaga show_line_diagnostics<CR>", desc = "Show Diagnostic" },
      { "<leader>lt", mode = { "n" }, "<CMD>Lspsaga term_toggle<CR>", desc = "Toggle Terminal" },
      { "<leader>lh", mode = { "n" }, "<CMD>Lspsaga hover_doc<CR>", desc = "Hover Documentation" },
      { "<leader>lo", mode = { "n" }, "<CMD>Lspsaga outline<CR>", desc = "Outline" },
      { "<leader>rn", mode = { "n" }, "<CMD>Lspsaga rename<CR>", desc = "Rename" },
      { "gi", mode = { "n" }, vim.lsp.buf.implementation, desc = "Incoming Calls" },
      { "<leader>lsf", vim.lsp.buf.declaration, desc = "Display function signature" },
      { "<leader>lsh", vim.lsp.buf.signature_help, desc = "Symbol signature help" },
      { "<leader>lc", group = "Calls" },
      { "<leader>lci", mode = { "n" }, "<CMD>Lspsaga incoming_calls<CR>", desc = "Incoming Calls" },
      { "<leader>lco", mode = { "n" }, "<CMD>Lspsaga outgoing_calls<CR>", desc = "Outgoing Calls" },
      -- Go to definition
      { "gd", vim.lsp.buf.definition, desc = "Goto definition" },
      { "K", vim.lsp.buf.hover, desc = "Hover" },
      -- Go to declaration
      { "lgD", vim.lsp.buf.declaration, desc = "Goto declaration" },
      { "<leader>fS", vim.lsp.buf.workspace_symbol, desc = "Workspace symbol search" },
      { "gt", vim.lsp.buf.type_definition, desc = "Goto type definition" },
    },
  },
}
