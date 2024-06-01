# dotfiles

These are my dotfiles, i.e. what I need to turn an arbitrary Linux machine into
a productive development environment. It's concentrated - just add internet!

By "arbitrary Linux machine", I really mean "An x86\_64 machine running a
recent version of Debian/Ubuntu/Mint, RHEL/CentOS/Rocky, or SUSE".

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

The nvim configuration features the following (probably excessive) list of
plugins, which will be automatically installed by install.sh:

- `coc`, with language support extensions and/or language server configuration
  for Python, TypeScript/JavaScript, terraform, HTML, CSS, JSON, Haskell
- `fzf` and `fzf.vim`, with custom ripgrep options and custom keybinds
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
- `hexokinase` to show true-colour swatch previews
- my own `sh-heredoc-highlighting` for syntax highlighting of embedded code in
  shell heredocs
- various syntax plugins for better language support

Almost all of the custom keybinds are used to drive these plugins - for vanilla
vim functionality I stick to the defaults.
