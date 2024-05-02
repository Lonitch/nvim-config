return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				-- define LSP servers here for LUA, RUST, JS/TS, and PYTHON
				ensure_installed = { "lua_ls", "rust_analyzer", "tsserver" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- Capabilities required for the visualstudio lsps (css, html, etc)
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			local lspconfig = require("lspconfig")
			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
			})
			lspconfig.cssls.setup({
				capabilities = capabilities,
			})
			lspconfig.html.setup({
				capabilities = capabilities,
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.tsserver.setup({
				capabilities = capabilities,
			})
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				filetypes = { "rust" },
				settings = {
					["rust-analyzer"] = {
						cargo = { allFeatures = true },
						procMacro = {
							ignored = {
								leptos_macro = {
									-- optional: --
									"component",
									"server",
								},
							},
						},
					},
				},
			})
		end,
	},
}
