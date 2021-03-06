# dotfiles

These are my dotfiles, i.e. what I need to turn an arbitrary Linux machine into
a productive development environment. It's concentrated - just add internet!

It does assume that the following are pre-installed (should be done via your system package manager):

- perl 5.8+
- python3 and pip3
- nodejs and npm (for CoC)

Mostly consists of neovim configuration for Python, Javascript and Terraform development.
The script [install.sh](install.sh) will attempt to find the following pieces of
software, and install any missing ones as universal amd64 binaries from the internet:

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

- `coc`, with language support extensions for python, typescript/javascript,
  terraform, HTML, CSS, and JSON
- `fzf` and `fzf.vim`, with custom ripgrep options and custom keybinds
- `easy-align` for easy (but still manually triggered) alignment
- the `gruvbox` colorscheme
- the `airline` status bar
- many of Tim Pope's brilliant plugins:
  - `vinegar` for a smoother directory navigation experience in netrw
  - `fugitive` and `rhubarb` for a nice git(hub) UI
  - `commentary` for easy (un)commenting
  - `speeddating` extend C-A/C-X bindings to work for dates and times
  - `surround` to manipulate surrounding pairs of brackets, etc
  - `sleuth` to automatically determine indentation conventions
- `hexokinase` to show true colour swatch previews
- my own `sh-heredoc-highlighting` for syntax highlighting of embedded code in
  shell heredocs
- various syntax plugins for better language support

Almost all of the custom keybinds are used to drive these plugins - for vanilla
vim functionality I stick to the defaults.
