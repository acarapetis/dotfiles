# dotfiles

These are my dotfiles, i.e. what I need to turn an arbitrary Linux machine into
a productive development environment. It's concentrated - just add internet!

It does assume that python3 and pip3 are installed (usually from your system package manager).

Mostly consists of neovim configuration for Python, Javascript and Terraform development.
The script <./install.sh> will attempt to find the following pieces of
software, and install any missing ones from the internet:

- jq
- nvim
- ripgrep
- vim-plug

It will then install the following configuration files via symlinks:

- nvim
- tmux
- nethack

The vim configuration features the following (probably excessive) list of plugins:

- `coc`, with language support extensions for python, typescript/javascript,
  terraform, HTML, CSS, and JSON
- `fzf` and `fzf.vim`, with custom ripgrep options and custom keybinds
- `easy-align` for easy (but still manually triggered) alignment
- the `gruvbox` colorscheme
- the `airline` status bar
- many of Tim Pope's brilliant plugins:
  - `vinegar` for a smoother directory navigation experience in netrw
  - `fugitive` is a nice built-in Git UI
  - `commentary` for easy (un)commenting
  - `speeddating` extend C-A/C-X bindings to work for dates and times
  - `surround` to manipulate surrounding pairs of brackets, etc
  - `sleuth` to automatically determine indentation conventions
- my own `sh-heredoc-highlighting` for syntax highlighting of embedded code in
  shell heredocs
- various syntax plugins for better language support

Almost all of the custom keybinds are used to drive these plugins - for vanilla
vim functionality I stick to the defaults.
