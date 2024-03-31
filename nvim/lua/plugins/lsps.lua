-- All this code was stolen so don't blame me if it looks like shit

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Float diagnostics" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Set location list" })

local group = vim.api.nvim_create_augroup("UserLspConfig", {})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(ev)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = function(desc)
      return { buffer = ev.buf, desc = desc }
    end
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Hover"))
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts("Signature help"))
    -- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
    -- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
    -- vim.keymap.set("n", "<space>wl", function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts("List workspace folders"))
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts("Type definition"))
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts("Rename symbol"))
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts("Code actions"))
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts("Go to references"))
    vim.keymap.set("n", "<space>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts("Format"))
  end,
})

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      -- Needs to be loaded before lspconfig, that's the only reason it's in this file
      require("neodev").setup()

      local lspconfig = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- Required for ufo plugin. Make sure to add `capabilities=capabilities` to any new server
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      -- Rust
      lspconfig.rust_analyzer.setup({
        -- Setup for clippy development, leaving it in case
        init_options = {
          ["rust-analyzer.rustc.source"] = "discover",
        },
        settings = {
          ["rust-analyer"] = {},
        },
        capabilities = capabilities,
      })
      -- Lua
      -- Previously was manually doing the config neodev does, leaving it in case
      lspconfig.lua_ls.setup({
        -- on_init = function(client)
        --   local path = client.workspace_folders[1].name
        --   if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
        --     return
        --   end
        --
        --   client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
        --     runtime = {
        --       -- Tell the language server which version of Lua you're using
        --       -- (most likely LuaJIT in the case of Neovim)
        --       version = "LuaJIT",
        --     },
        --     diagnostics = {
        --       globals = { "vim", "require" },
        --     },
        --     -- Make the server aware of Neovim runtime files
        --     workspace = {
        --       checkThirdParty = false,
        --       library = {
        --         vim.env.VIMRUNTIME,
        --       },
        --     },
        --   })
        -- end,
        settings = {
          Lua = {
            diagnostics = { disable = { "missing-fields" } },
          },
        },
        capabilities = capabilities,
      })
    end,
  },
  -- haskell-tools sets up hls so no need to set it above
  {
    "mrcjkb/haskell-tools.nvim",
    version = "^3", -- Recommended
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    init = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = group,
        callback = function(ev)
          if vim.fn.getbufvar(ev.buf, "&filetype") ~= "haskell" then
            return
          end
          local opts = function(desc)
            return { buffer = ev.buf, desc = desc, silent = true }
          end

          local ht = require("haskell-tools")
          -- haskell-language-server relies heavily on codeLenses,
          -- so auto-refresh (see advanced configuration) is enabled by default
          vim.keymap.set("n", "<space>lc", vim.lsp.codelens.run, opts("Run codelens"))
          -- Hoogle search for the type signature of the definition under the cursor
          vim.keymap.set("n", "<space>lh", ht.hoogle.hoogle_signature, opts("Hoogle type signature"))
          -- Evaluate all code snippets
          vim.keymap.set("n", "<space>le", ht.lsp.buf_eval_all, opts("Evaluate all code snippets"))
          -- Toggle a GHCi repl for the current package
          vim.keymap.set("n", "<leader>lr", ht.repl.toggle, opts("Toggle GHCi"))
          -- Toggle a GHCi repl for the current buffer
          vim.keymap.set("n", "<leader>lb", function()
            ht.repl.toggle(vim.api.nvim_buf_get_name(0))
          end, opts("Toggle GHCi for buffer"))
          vim.keymap.set("n", "<leader>lq", ht.repl.quit, opts("Quit GHCi"))
        end,
      })
    end,
  },
}
