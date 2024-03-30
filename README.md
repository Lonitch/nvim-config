# dotfiles for Neovim and tmux

<!-- mtoc-start -->

* [Intro](#intro)
* [Prerequisites](#prerequisites)
  * [Default terminal behavior in `tmux`](#default-terminal-behavior-in-tmux)
  * [Copy in tmux](#copy-in-tmux)
  * [Simple workflow with `tmux`](#simple-workflow-with-tmux)
* [Cheats sheet](#cheats-sheet)
  * [Workspace](#workspace)
  * [Markdown](#markdown)
  * [Add or delete things](#add-or-delete-things)
  * [Go-to places](#go-to-places)
  * [Folding code](#folding-code)
  * [Mode switching](#mode-switching)
  * [Tabs and windows](#tabs-and-windows)
  * [Change surrounds](#change-surrounds)
  * [Commenting and formatting](#commenting-and-formatting)
  * [Programming hints](#programming-hints)
  * [Find things](#find-things)
  * [Debugging](#debugging)
  * [Git](#git)
  * [Terminal](#terminal)

<!-- mtoc-end -->

## Intro

This repo gives the `nvim` config for developing with Rust and/or JS(TS). It has following features:

- hartime.nvim for self-discplined usage(bad habbits prohibitors and better workflow hints)
- auto-completion
- auto-formatting at save for Rust
- auto-pair of ""/[]/{}
- LSP for TS/JS/Rust(Leptos)/Python
- codelldb debugging by following the steps [here](<https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)>)
- you need to change the absolute path to `codelldb` in [debugging.lua](/lua/plugins/debugging.lua)
- You might consider using `tmux` for session management

## Prerequisites

- `ripgrep`
- `tmux`( if session management is important )
- `leptosfmt`( if use `leptos` )
- `node` and `npm`
- `eslint` ( if using LSP for TS/JS in your project )
- [ `black` ](https://github.com/psf/black)(formatting python)
- `vscode-langservers-extracted` (install via npm/bun)
- `setxkbmap -option ctrl:nocaps` in cmd to disable CapsLock(optional, use `setxkbmap -option` to restore)

<details>
<summary><b>tmux Configuration</b></summary>

Recommended configuration for [ `~/.tmux.conf` ](./.tmux.conf)

### Default terminal behavior in `tmux`

To make pane behaves like normal terminal, `shift` should be hold. For example, to paste stuff from clipboard in `tmux` terminal pane, you need `shift+right click`.

### Copy in tmux

- enter copy mode: `<C-a>-[`
- move around using `h/j/k/l/0/$`
- begin copy highlighting: `<space>` or `v`
- copy: `<CR>` or `y`
- paste with `<C-a>+]`
- exit copy mode: `<C-c>`

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

</details>

## Cheats sheet

### Workspace

<details><summary>details</summary>

A workspace is a folder containing multiple git repositories. Here we use [`projections.nvim`](https://github.com/GnikDroy/projections.nvim/tree/pre_release?tab=readme-ov-file) to manage workspaces. Using it gives you the following options:

- `:AddWorkspace` to register current folder as a workspace
- `<leader>fp` to list all the projects in current workspace
- automatically save current `neovim` session. Next time when you are at a project folder, the latest session is restored.

</details>

### Markdown

<details><summary>details</summary>

- `:Mtoc i`: insert ToC
- `:Mtoc u`: update ToC
- `:Mtoc r`: remove ToC

</details>

### Add or delete things

<details><summary>details</summary>

In `neotree`:

- `a`: add file/folder
- `d`: delete file/folder
- `r`: rename

</details>

### Go-to places

<details><summary>details</summary>

- `g;`: go to last changed place
- `gi`: go to last place and insert
- `<space><space>b`: go to next opened buffer
- `<space>bb`: go to previous opened buffer
- `gt`: go to the last tab
- `<space>j`: jump to the bottom line and centers the window at the line(page-down)
- `<space>m`: jump to the top line and centers the window(page-up)
- `<space>gd`: go to definition

</details>

### Folding code

<details><summary>details</summary>

- `zo/c`: open/close fold under the cursor
- `zO/C`: open/close fold recursively under the cursor, folds without cursor in them unaffected
- `zR`: open all folds
- `zM`: close all folds

</details>

### Mode switching

<details><summary>details</summary>

- `<Alt-f>`: escape insert mode and jump out of current paired ""/[]/{}/()/''/,/``

</details>

### Tabs and windows

<details><summary>details</summary>

- `<space>+<Tab>`: switch windows
- `tabe .`: create a new tab

In `telescope`(either `<leader>ff`, or `<leader>lg`), you can

- `<C-x>`: Go to file selection as a split
- `<C-v>`: Go to file selection as a vsplit

</details>

### Change surrounds

<details><summary>details</summary>

| Old text                       | Command   | New text                   |
| :----------------------------- | :-------- | :------------------------- |
| surr\*ound_words               | ysiw      | (surround_words)           |
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

</details>

### Commenting and formatting

<details><summary>details</summary>

- `<Ctrl-/>`: comment current line
- `<space>gf`: global formatting
- `[count]gcc`: Toggles the number of line given as a prefix-count using line wise
- `[count]gbc`: Toggles the number of line given as a prefix-count using block wise
- `gc`: toggle the selected region using linewise comment
- `gb`: toggle the selected region using blockwise comment

</details>

### Programming hints

<details><summary>details</summary>

- `<space>k`: see function info
- `<space>a`: see code actions

</details>

### Find things

<details><summary>details</summary>

- `<space>h`: remove search highlights
- `<space>n`: open/close neotree file system, use `f`/`b`/`g`/`c` to open filesystem/buffers/git/components tabs
- `<space>ff`: open telescope file finder
- `<space>lg`: open telescope live grep
- `<space>bo`: show all opened buffers
- `<Ctrl-q>`: save live-grep results from telescope to a split window at the bottom

</details>

### Debugging

<details><summary>details</summary>

- `<leader>od`: "open debug ui"
- `<leader>cd`: "close debug ui"
- `<leader>tb`: "toggle breakpoint"
- `<leader>=`: "start debugger/continue"
- `<leader>-`: "step over debugger"
- `<space><space>f`: open floating msg from LSP at current line

</details>

### Git

<details><summary>details</summary>

`git-fugitive` and `vim-flog` are currently added to run git commands in nvim. You can use `:Git` to run commands just like you do in terminal. Some examples are:

- `<leader>gp`: preview the hunk of current line
- `:Git add`: `git add` in terminal
- `:Git commit`: `git commit` in terminal

Use `:Flog` to open a new tab that shows results of `git log`. The new tab contains info of all commits. You can find out what this command can do by `:help Flog`. Here we recommend 3 use cases:

- Checking out a branch:

  - use `:Flog` to open new tab that shows all the commits
  - hit "a" to show all hidden commits
  - navigate to the branch you desire
  - use `cob` to checkout the branch

- View history of selected lines of code

  - in visual mode, select lines of code of your interest
  - use `:Flog` to open a new tab to show the past history relevant only to the selected snippet

- View history of specific file

```bash
:Flog -path=path/to/file
```

</details>

### Terminal

<details><summary>details</summary>

- `:terminal`: open a terminal in neovim as a split window
- `i/I/a/A`: insert in terminal window
- `<C-\><C-O>`: exit typing mode

</details>
