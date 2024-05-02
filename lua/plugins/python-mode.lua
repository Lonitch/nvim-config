return {
	"python-mode/python-mode",
	branch = "develop",
	ft = { "python", "qmd" },
	config = function()
		vim.g.pymode_python = "python3"
		vim.g.pymode_lint = 1
		vim.g.pymode_rope = 1
		vim.g.pymode_folding = 0
		vim.g.pymode_options_max_line_length = 88
		vim.g.pymode_lint_checkers = { "pyflakes", "pep8", "mccabe" }
    vim.g.pymode_rope_completion = 1
    vim.g.pymode_rope_autoimport = 0
    vim.g.pymode_rope_autoimport_modules = {'os', 'shutil', 'datetime'}
    vim.g.pymode_rope_autoimport_import_after_complete = 1
    vim.g.pymode_rope_complete_on_dot = 1
    vim.g.pymode_rope_goto_definition_bind = '<space>gd'
    vim.g.pymode_rope_goto_definition_cmd = 'vnew'
    vim.g.pymode_rope_project_root = ""
    vim.g.pymode_rope_regenerate_on_write = 1
    vim.g.pymode_rope_lookup_project = 1
	end,
}
