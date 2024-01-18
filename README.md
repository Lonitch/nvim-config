# Neovim Configs 

This repo gives the `nvim` config for developing with Rust and/or JS(TS). It has following features:
- auto-completion
- auto-formatting at save for Rust 
- auto-pair of ""/[]/{}
- LSP for TS/JS/Rust
- codelldb debugging by following the steps [here](https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb))
    - you need to change the absolute path to `codelldb` in [debugging.lua](/lua/plugins/debugging.lua) 

## Cheats sheet

- `g;`: go to last changed place
- `gi`: go to last place and insert
- `<space>b`: go to next opened buffer 
- `<space><space>b`: go to previous opened buffer 
- `zo/c`: open/close fold under the cursor
- `zO/C`: open/close fold recursively under the cursor, folds without cursor in them unaffected
- `zR`: open all folds 
- `zM`: close all folds 
- `<space>+<Tab>`: switch windows 
- `<Ctrl-/>`: comment current line
- `Alt+f`: escape insert/select mode 
- `<space>a`: see code actions
- `<space>h`: remove search highlights 
- `<space>n`: open/close neotree file system, use `f`/`b`/`g`/`c` to open different tabs 
- `<space>ff`: open telescope file finder 
- `<space>lg`: open telescope live grep 
- `<leader>od`: "open debug ui"
- `<leader>cd`: "close debug ui"
- `<leader>tb`: "toggle breakpoint"
- `<leader>=`: "start debugger/continue"
- `<leader>-`: "step over debugger"
