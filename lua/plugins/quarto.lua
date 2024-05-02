return {
	"jmbuhr/otter.nvim",
	"quarto-dev/quarto-nvim",
	config = function()
		local quarto = require("quarto")
		quarto.setup({
			debug = false,
			closePreviewOnExit = true,
			lspFeatures = {
				enabled = true,
				chunks = "curly",
				languages = { "r", "python", "julia", "bash", "html" },
				diagnostics = {
					enabled = true,
					triggers = { "BufWritePost" },
				},
				completion = {
					enabled = true,
				},
			},
			codeRunner = {
				enabled = false,
				default_method = nil, -- 'molten' or 'slime'
				ft_runners = {}, -- filetype to runner, ie. `{ python = "molten" }`.
				-- Takes precedence over `default_method`
				never_run = { "yaml" }, -- filetypes which are never sent to a code runner
			},
			keymap = false
        -- {
				-- set whole section or individual keys to `false` to disable
				-- hover = "<leader>k",
				-- definition = "<leader>gd",
				-- type_definition = "gD",
				-- rename = "<leader>lR",
				-- format = "<leader>lf",
				-- references = "<leader>gr",
				-- document_symbols = "<leader>gS",
			-- },
		})
	end,
}
