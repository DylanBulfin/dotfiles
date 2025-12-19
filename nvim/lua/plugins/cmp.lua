return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = {
			"L3MON4D3/LuaSnip",
			version = "v2.*",
      build = "make install_jsregexp"
		},
		opts = {
			keymap = {
				preset = "super-tab",
			},
			completion = {
				documentation = {
					auto_show = true,
				},
			},
			sources = {
				default = {
					"lsp",
					-- 'path',
					"snippets",
					-- 'buffer'
				},
			},
		},
	},
}
