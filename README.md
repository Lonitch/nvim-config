# Neovim Configs

This repo gives the `nvim` config for developing with Rust and/or JS(TS). It has following features:

- hartime.nvim for self-discplined usage(bad habbits prohibitors and better workflow hints)
- auto-completion
- auto-formatting at save for Rust
- auto-pair of ""/[]/{}
- LSP for TS/JS/Rust(Leptos)
- codelldb debugging by following the steps [here](<https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)>)
- you need to change the absolute path to `codelldb` in [debugging.lua](/lua/plugins/debugging.lua)
- You might consider using `tmux` for session management

## Prerequisites

- `ripgrep`
- `tmux`( if session management is important )
- `leptosfmt`( if use `leptos` )
- `node` and `npm`
- `eslint` ( if using LSP for TS/JS )
- `setxkbmap -option ctrl:nocaps` in cmd to disable CapsLock(optional, use `setxkbmap -option` to restore)

## `tmux` Configuration

Recommended configuration in `~/.tmux.conf` is the following:

```bash
set -g default-terminal "screen-256color"

# set command prefix to CTRL+a
set -g prefix C-a
unbind C-b
bind-key C-a send-prefix

# use | to open vertical pane in session
unbind %
bind | split-window -h

# use - to open horizontal pane in session
unbind '"'
bind - split-window -v

# hit r to refresh tmux settings, first time refresh: tmux source-file ~/.tmux.conf
unbind r
bind r source-file ~/.tmux.conf

# resize panes using h(left)/j(down)/k(up)/l(right)
bind -r j resize-pane -D 5
bind -r k resize-pane -U 5
bind -r l resize-pane -R 5
bind -r h resize-pane -L 5

# use m to minimize/maximize current pane
bind -r m resize-pane -Z

# enable vi copy mode
setw -g mode-keys vi
bind-key -T copy-mode-vi 'v' send -X begin-selection
bind-key -T copy-mode-vi 'y' send -X copy-selection


# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tpope/vim-obsession'

# persist tmux sessions after pc restart
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'
set -g @resurrect-strategy-nvim 'session'
set -g @resurrect-capture-pane-contents 'on'
set -g @continuum-restore 'on'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
```

### Default terminal behavior in `tmux`

`tmux` do not support default behavior by default. To make pane behaves like normal terminal, `shift` should be hold. For example, to paste stuff from clipboard in `tmux` terminal pane, you need `shift+right click`.

### Restore neovim session 
If running `tmux` after restart does not restore your neovim session, you can do the following:
1. run `:mksession!` neovim, this cmd will create a `Session.vim`in your current path
2. run `<C-a>+<C-s>` to store your current session
3. restart 
4. open terminal, and run `tmux`
5. in the pane used to run neovim, restore its session by running `nvim -S`

### Copy in tmux

- enter copy mode: <C-a>+[
- move around using h/j/k/l/0/$
- begin copy highlighting: <space> or v
- copy: <CR> or y
- paste with <C-a>+]
- exit copy mode: <C-c>

### Simple workflow with `tmux`

```bash
# in terminal, create a new session
tmux new -s sessionName
# detach from a session
tmux detach
# attach to a session
tmux attach -t sessionName
# kill a session/window
tmux kill-session -t sessionName
# if you have pre-stored session, simply run 
tmux

# create a horizontal pane using <C-a>+-
# adjust the height of the two panes using j/k
# switch between panes using <C-a>+↑/↓
# close pane by typing 'exit'
# open neovim in upper pane, run terminal cmd in lower pane

# for full-stack dev., it's useful to create 2 windows in a session
# create a new window: <C-a>+c
# switch between windows: <C-a>+w
# <C-a>+c to create new window
```

## Cheats sheet

### Add or delete things

In `neotree`:

- `a`: add file/folder
- `d`: delete file/folder
- `r`: rename

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

| Old text                       | Command   | New text                   |
| :----------------------------- | :-------- | :------------------------- |
| surr\*ound_words               | ysiw)     | (surround_words)           |
| \*make strings                 | ys$"      | "make strings"             |
| require"nvim-surroun\*d"       | ysa")     | require("nvim-surround")   |
| char c = \*x;                  | ysl'      | char c = 'x';              |
| int a[] = \*32;                | yst;}     | int a[] = {32};            |
| hel\*lo world                  | yss"      | "hello world"              |
| [delete ar*ound me!]           | ds]       | delete around me!          |
| remove \<b\>HTML t\*ags\<\/b\> | dst       | remove HTML tags           |
| 'change quot\*es'              | cs'"      | "change quotes"            |
| \<b\>or tag\* types\<\/b\>     | csth1<CR> | \<h1\>or tag types\<\/h1\> |
| delete(functi\*on calls)       | dsf       | function calls             |

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
