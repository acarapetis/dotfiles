# dotfiles

These are my dotfiles, i.e. what I need to turn an arbitrary Linux machine into a
productive CLI-focused development environment. It's concentrated - just add internet!

By "arbitrary Linux machine", I really mean "An x86\_64 machine running a
recent version of Debian/Ubuntu/Mint, RHEL/CentOS/Rocky, or SUSE". Note that
I've been using exclusively Debian-based distros for a few years now, so the
redhat/SUSE support is untested.

## Setup

The script [install.sh](install.sh) will attempt to find most of the software listed in
the next section, and install missing ones from your system package manager or as
universal amd64 binaries from the internet. (Current exceptions that need manual
installation: i3, jj, rustup/cargo).

It will then install the configuration files in ./config and ./home_dotfiles
using symlinks, and ./bashrc.inc and ./gitconfig using includes.

## Tools of the trade

- **editor**: neovim (+ plugins via lazy.nvim), tailored for
    - Python
    - HTML/XML + Jinja2
    - TypeScript/JavaScript (including lit-html template support)
    - C/C++
    - Terraform
    - Bash
    - Rust
- **source control**: git, jj
- **getting around**: tmux, bash, starship, rg, fd, fzf
- **GUI**: i3, i3status, rofi
- **utilities**: curl, jq, up (ultimate plumber), pspg, custom scripts in <bin/>
