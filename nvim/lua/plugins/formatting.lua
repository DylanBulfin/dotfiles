return {
    {
        "stevearc/conform.nvim",
        config = function()
            local conform = require("conform")
            conform.setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                },
                format_on_save = {
                    lsp_fallback = true,
                },
                formatters = {
                    stylua = {
                        prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
                    },
                },
            })
        end,
    },
}
