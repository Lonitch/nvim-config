return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			debug = true,
			sources = {
				-- auto-format lua
				null_ls.builtins.formatting.stylua,
				-- js formatting
				-- require("none-ls.formatting.prettier"),
				null_ls.builtins.formatting.prettier,
				-- eslint diagnostics
				-- require("none-ls.diagnostics.eslint"),
				require("none-ls.code_actions.eslint"),
				-- null_ls.builtins.formatting.eslint,
				-- spell completion
				-- require("none-ls.completion.spell"),
				null_ls.builtins.completion.spell,
			},
		})
	end,
}
