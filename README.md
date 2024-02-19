# Neovim Configs 

This repo gives the `nvim` config for developing with Rust and/or JS(TS). It has following features:
- hartime.nvim for self-discplined usage(bad habbits prohibitors and better workflow hints)
- auto-completion
- auto-formatting at save for Rust 
- auto-pair of ""/[]/{}
- LSP for TS/JS/Rust(Leptos)
- codelldb debugging by following the steps [here](https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb))
    - you need to change the absolute path to `codelldb` in [debugging.lua](/lua/plugins/debugging.lua) 

## Prerequisites 
- `ripgrep`
- `leptosfmt`
- `node` and `npm`
- `eslint` if using LSP for TS/JS
- `setxkbmap -option ctrl:nocaps` in cmd to disable CapsLock(optional, use `setxkbmap -option` to restore)

## Cheats sheet

### Add or delete things 
In `neotree`:
- `a`: add file/folder
- `d`: delete file/folder 

### Go-to places
- `g;`: go to last changed place
- `gi`: go to last place and insert
- `<space><space>b`: go to next opened buffer 
- `<space>bb`: go to previous opened buffer 
- `gt`: go to the last tab
- `<space>j`: jump to the bottom line and centers the window at the line(page-down)
- `<space>m`: jump to the top line and centers the window(page-up)
- `<space>gd`: go to definition

### Folding code
- `zo/c`: open/close fold under the cursor
- `zO/C`: open/close fold recursively under the cursor, folds without cursor in them unaffected
- `zR`: open all folds 
- `zM`: close all folds 

### Mode switching
- `<Alt-f>`: escape insert mode and jump out of current paired ""/[]/{}/()/''/,/``

### Tabs and windows
- `<space>+<Tab>`: switch windows 
- `tabe .`: create a new tab

### Change surrounds 
- `sr"'`: replace current "" surrounds with ''
- `saiw]`: wrap current word with []
- `sas"`: wrap current line with ""
- `sd"`: delete surrounds of ""

### Commenting and formatting
- `<Ctrl-/>`: comment current line
- `<space>gf`: global formatting
- `[count]gcc`: Toggles the number of line given as a prefix-count using line wise
- `[count]gbc`: Toggles the number of line given as a prefix-count using block wise
- `gc`: toggle the selected region using linewise comment 
- `gb`: toggle the selected region using blockwise comment 

### Programming hints
- `<space>k`: see function info
- `<space>a`: see code actions

### Find things
- `<space>h`: remove search highlights 
- `<space>n`: open/close neotree file system, use `f`/`b`/`g`/`c` to open filesystem/buffers/git/components tabs
- `<space>ff`: open telescope file finder 
- `<space>lg`: open telescope live grep 
- `<space>bo`: show all opened buffers
- `<Ctrl-q>`: save live-grep results from telescope to a split window at the bottom

### Debugging
- `<leader>od`: "open debug ui"
- `<leader>cd`: "close debug ui"
- `<leader>tb`: "toggle breakpoint"
- `<leader>=`: "start debugger/continue"
- `<leader>-`: "step over debugger"
- `<space><space>f`: open floating msg from LSP at current line

### Git 
- `<leader>gp`: preview the hunk of current line
- `:Git add`: `git add` in terminal
- `:Git commit`: `git commit` in terminal

### Terminal 
- `:terminal`: open a terminal in neovim as a split window
- `i/I/a/A`: insert in terminal window
- `<C-\><C-O>`: exit typing mode
