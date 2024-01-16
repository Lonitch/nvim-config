-- make tab to be 2*space
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
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
    return l ~= ''
end

if not is_cmd_available("rg") then
    print("ripgrep not found, installing...")
    os.execute("sudo apt-get install ripgrep")
end

-- lazy.vim set up plugins with options here
require("lazy").setup("plugins")

-- global key map
-- '-' goes to the line end
vim.keymap.set('n','-','<End>')

