# Neovim Configs 

This repo gives the `nvim` config for developing with Rust and/or JS(TS). It has following features:
- auto-completion
- auto-formatting at save for Rust 
- auto-pair of ""/[]/{}
- LSP for TS/JS/Rust
- codelldb debugging by following the steps [here](https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb))
    - you need to change the absolute path to `codelldb` in [debugging.lua](/lua/plugins/dugging.lua) 

## Cheats sheet

- `<space>+<Tab>`: switch windows 
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
