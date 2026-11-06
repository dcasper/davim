# AGENTS.md — davim (dotfiles)

## What this is

Personal dotfiles repo. No application source code. Config files for vim, zsh, tmux, screen, karabiner, and pry, managed as symlinks into `~`.

## Setup

`./setup.sh` creates symlinks from the repo root into `~` for `.vim`, `.vimrc`, `.screenrc`, `.zshenv`, `.zshrc`, `.tmux.conf`, and `karabiner.edn`. It must be run from the repo directory — it uses `$(pwd)` to resolve paths. Run `:PlugInstall` inside vim after setup to fetch plugins.

## Proprietary config pattern

`.zshrc` sources `~/.proprietary/*.zshrc.pre` before oh-my-zsh and `~/.proprietary/*.zshrc` after. The `.proprietary/` directory is gitignored — use it for secrets or machine-specific overrides.

## Key gotchas

- **`.zshrc` has hardcoded macOS paths** (`/Users/davidcasper/...`, `/usr/local/Caskroom/...`, `/usr/local/Cellar/...`). These are dead on Linux and may break sourcing. Guard edits to `.zshrc` with path checks or skip the broken blocks.
- **tmux prefix**: `C-b` is bound to `last-window` (line 63 of `.tmux.conf`), and the default `C-b` prefix is unset (`set -g prefix None`). The actual prefix is triggered via `bind-key -n C-b` which also shows session info on narrow windows.
- **vim-plug auto-install**: `.vimrc` auto-downloads `plug.vim` on first run and syncs plugins. Don't commit state from `.vim/plugged/` — it's gitignored.
- **Old git submodules** in `.gitmodules` reference `.vim/bundle/` which is deprecated in favor of vim-plug. Ignore the submodules; the README notes they are outdated.
- **Vagrant bootstrap** (`vagrant/bootstrap.sh`) is outdated (Ruby 2.3.4, Rails 4.2.6, pg 9.6 on Trusty). Treat as historical reference only.

## Config files at a glance

| File | Tool | Notes |
|---|---|---|
| `.vimrc` | Vim/Neovim | vim-plug, vim-lsp + fzf, gruvbox-material colorscheme, `jk` escapes insert mode |
| `.zshrc` | Zsh | oh-my-zsh, rbenv, nvm, pyenv, conda, mise, go, opencode |
| `.zshenv` | Zsh | RVM only (loaded early) |
| `.tmux.conf` | Tmux | vi mode keys, Ctrl-H/J/K/L pane switching, status hides on narrow windows (<90 cols) |
| `.screenrc` | Screen | 256-color, 10k scrollback |
| `.connector-screenrc` / `.portal-screenrc` | Screen | Project-specific multi-pane layouts (Rails apps, historical) |
| `karabiner.edn` | Karabiner | Caps Lock → mouse layer, Shift double-tap → arrow layer |
| `.pryrc` | Pry | Debugger aliases (`c`, `s`, `n`, `f`, `b`) |

## Vim conventions

- 2-space indent, expandtab
- `jk` exits insert mode
- `<Leader>=` / `<Leader>-` resize windows vertically, `<Leader>,` / `<Leader>.` horizontally
- Folding is syntax-based and starts expanded (`foldlevel=99`); `z1`–`z6` collapse to fold level N; fold text shows the fold's first line and line count
- LSP via vim-lsp, registered for JS/TS only when `typescript-language-server` is on PATH: `gd` definition, `gD` declaration, `gr` references, `gi` implementation, `gy`/`gY` type definition, `K` hover, `<Leader>rn` rename, `<Leader>ca` code action, `[d` / `]d` prev/next diagnostic. Diagnostics echo on the cursor line (no virtual text) and are disabled in diff buffers; the sign column is hidden
- fzf replaces CtrlP: `<C-P>` opens `:GitFiles`, `<C-L>` opens `:History`, both in a floating window
- Relative line numbers hide when the window is narrower than 90 columns
- After a buffer loads, file details echo on the command line after a short delay (`g:file_info_delay` ms, default 75; negative disables)
- Prettier autoformats on save for its filetypes (`g:prettier#autoformat = 1`); `:Black` formats Python manually
