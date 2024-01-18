-- make tab to be 2*space
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
-- show relative line numbers
vim.cmd("set relativenumber")
-- fold code
vim.cmd("set foldmethod=indent")
-- Disable folding in Telescope's result window.
vim.api.nvim_create_autocmd("FileType", { pattern = "TelescopeResults", command = [[setlocal nofoldenable]] })
-- <leader> => <space>
vim.g.mapleader = " "

-- install lazy.vim pkg manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- install ripgrep on ubuntu, you might change it on
-- different OS.
local function is_cmd_available(name)
  local f = io.popen("which " .. name)
  local l = f:read("*a")
  f:close()
  return l ~= ""
end

if not is_cmd_available("rg") then
  print("ripgrep not found, installing...")
  os.execute("sudo apt-get install ripgrep")
end

-- lazy.vim set up plugins with options here
require("lazy").setup("plugins")

-- GLOBAL KEY REMAPPING
-- '-' goes to the line end
vim.keymap.set("n", "-", "<End>")
-- '<space>h' remove search hight light
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
-- Alt+f to escape insert/select/replace mode
vim.keymap.set("i", "<A-f>", "<C-[>")
vim.keymap.set("v", "<A-f>", "<C-[>")
vim.keymap.set("t", "<A-f>", "<C-[>")
-- <space>+tab to switch windows
vim.keymap.set("n", "<leader><Tab>", "<C-w><C-w>")

-- FORMATTER KEY REMAPPING
-- <space>+g+f: enable global formatter
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
-- LSP KEY REMAPPING
-- <space> + k to show documentation of hovered word
vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, {})
-- <space>+g+d: go to definition
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
-- <space>+a: selects a code action available at the current position
vim.keymap.set("n", "<space>a", vim.lsp.buf.code_action, {})

-- DEBUGGING KEY REMAPPING
vim.keymap.set("n", "<leader>od", ":lua require'dapui'.open()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>cd", ":lua require'dapui'.close()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tb", ":lua require'dap'.toggle_breakpoint()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>=", ":lua require'dap'.continue()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>-", ":lua require'dap'.step_over()<CR>",{ noremap = true, silent = true })

-- COMMENTING 
vim.keymap.set("n", "<C-_>", function() require('Comment.api').toggle.linewise.current() end, { noremap = true, silent = true })
