return {
	"python-mode/python-mode",
	branch = "develop",
	ft = { "python", "qmd" },
	config = function()
		vim.g.pymode_python = "python3"
		vim.g.pymode_lint = 1
		vim.g.pymode_folding = 0
		vim.g.pymode_lint_checkers = { "pyflakes", "pep8", "mccabe" }
		vim.g.pymode_lint_options_pycodestyle = { max_line_length = 92 }
		vim.g.pymode_rope = 0
		vim.g.pymode_rope_completion = 0
    vim.g.pymode_rope_complete_on_dot = 1
    vim.g.pymode_completion_bind = '<Alt-!>'
    vim.g.pymode_rope_goto_definition_bind = '<C-c>g'
	end,
}
