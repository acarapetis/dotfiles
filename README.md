# dotfiles

These are my dotfiles, i.e. what I need to turn an arbitrary Linux machine into
a productive development environment. It's concentrated - just add internet!

By "arbitrary Linux machine", I really mean "An x86\_64 machine running a
recent version of Debian/Ubuntu/Mint, RHEL/CentOS/Rocky, or SUSE". Note that
I've been using exclusively Debian-based distros for a few years now, so the
redhat/SUSE support is untested.

## Contents

Mostly consists of neovim configuration for development using:

- Python (+Jinja2)
- TypeScript/JavaScript (including lit-html template support)
- Rust
- Bash
- Terraform
- Lua
- SQL
- HTML/XML
- JSON
- Docker

The script [install.sh](install.sh) will attempt to find the following pieces of
software, and install any missing ones from your system package manager or as
universal amd64 binaries from the internet:

- perl5
- python3 and pip3
- jq
- nvim
- ripgrep
- fzf
- rofi
- starship
- up (ultimate plumber)
- pspg

It will then install the configuration files in ./config and ./home_dotfiles
using symlinks, and ./bashrc.inc and ./gitconfig using includes.
