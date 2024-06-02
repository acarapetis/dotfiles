# dotfiles

These are my dotfiles, i.e. what I need to turn an arbitrary Linux machine into
a productive development environment. It's concentrated - just add internet!

By "arbitrary Linux machine", I really mean "An x86\_64 machine running a
recent version of Debian/Ubuntu/Mint, RHEL/CentOS/Rocky, or SUSE". Note that
I've been using exclusively Debian-based distros for a few years now, so the
redhat/SUSE support is untested.

It **assumes that NodeJS 12+ is pre-installed** - the best way to do this
varies by your distribution and situation. I usually use either the NodeSource
repositories for the system package manager, or conda-forge.

## Contents

Mostly consists of neovim configuration for development using:

- Python (+Jinja2)
- TypeScript/JavaScript (including lit-html template support)
- Haskell
- Rust
- Bash
- Terraform
- Docker
- HTML/XML
- JSON

The script [install.sh](install.sh) will attempt to find the following pieces of
software, and install any missing ones from your system package manager or as
universal amd64 binaries from the internet:

- perl5
- python3 and pip3
- golang
- jq
- nvim
- ripgrep
- vim-plug

It will then install configuration files for the following via symlinks or includes:

- bash
- tmux
- nvim
- git
- pylint
- nethack

The nvim configuration features the following (non-exhaustive and probably
excessive) list of plugins, which will be automatically installed by
install.sh:

- `nvim-cmp`, `mason-lspconfig`, and another 6 or so plugins that all come
  together to provide a solid language server experience - see `lsp.lua` for
  the complete list, or just check out [this
  article](https://lsp-zero.netlify.app/v3.x/blog/theprimeagens-config-from-2022.html)
  that I used as a starting point.
- `fzf` and `fzf-lua` to get around quickly
- `easy-align` for easy (but still manually triggered) alignment
- the `gruvbox` colorscheme
- the `lualine` status bar
- many of Tim Pope's brilliant plugins:
  - `vinegar` for a smoother directory navigation experience in netrw
  - `fugitive` and `rhubarb` for a nice git(hub) UI
  - `commentary` for easy (un)commenting
  - `speeddating` extend C-A/C-X bindings to work for dates and times
  - `surround` to manipulate surrounding pairs of brackets, etc
  - `sleuth` to automatically determine indentation conventions
  - `jdaddy` for JSON motions
  - `dadbod` for easy iteration on SQL queries
  - `eunuch` for the convenience of `:SudoWrite` and `:Rename`
  - `repeat` to allow . to repeat mappings from plugins
- my own `sh-heredoc-highlighting` for syntax highlighting of embedded code in
  shell heredocs
- various syntax plugins for better language support

Almost all of the custom keybinds are used to drive these plugins - for vanilla
vim functionality I stick to the defaults.
