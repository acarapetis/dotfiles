#!/bin/bash -e

SCRIPT_ARG="$1"
NVIM_LINK="https://github.com/neovim/neovim/releases/download/stable/nvim.appimage"
RG_LINK="https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz"
UP_LINK="https://github.com/akavel/up/releases/download/v0.4/up"
JQ_LINK="https://github.com/stedolan/jq/releases/download/jq-1.7.1/jq-linux64"
FZF_LINK="https://github.com/junegunn/fzf/releases/download/0.53.0/fzf-0.53.0-linux_amd64.tar.gz"

cd "$(dirname "$0")"
DOTFILES="$PWD"

mkdir -p ~/.local/bin
PATH="$PATH:$HOME/.local/bin"

for x in bin/*; do
    ln -fs "$DOTFILES/$x" ~/.local/bin/
done

for x in config/*; do
    ln -fs "$DOTFILES/$x" ~/.config/
done

pushd home_dotfiles
for x in *; do
    ln -fs "$DOTFILES/home_dotfiles/$x" ~/.$x
done
popd

confirm() {
    if [ "$SCRIPT_ARG" == "-y" ]; then
        return 0
    fi
    read -p "$1 [Y/n]" o
    [ -z "$o" ] || [ "${o^^}" == Y ]
}

tryinstall() {
    sudo apt install -y "$@" || sudo yum install -y "$@" || sudo zypper install -y "$@"
}

tryinstall python3-pip perl curl python3-pynvim
tryinstall pspg || >&2 echo "Couldn't install pspg, continuing anyway"

which jq || (curl -L "$JQ_LINK" -o ~/.local/bin/jq && chmod +x ~/.local/bin/jq)

if ! which nvim; then
    if confirm "nvim not found in path. Install appimage from github?"; then
        curl -fL -o nvim.appimage --create-dirs "$NVIM_LINK"
        chmod +x nvim.appimage
        ./nvim.appimage --appimage-extract >/dev/null
        mv squashfs-root ~/.local/nvim
        rm nvim.appimage
        ln -fs ~/.local/nvim/usr/bin/nvim ~/.local/bin/
        echo "Neovim installed to ~/.local/bin/nvim"
    fi
fi

if ! which up; then
    if confirm "Ultimate Plumber not found in path. Install binary from github?"; then
        (
            d=$(mktemp -d)
            cd "$d"
            curl -fLo ~/.local/bin/up "$UP_LINK"
            chmod +x ~/.local/bin/up
        )
        echo "up installed to ~/.local/bin/up"
    fi
fi

if ! which rg; then
    if confirm "rg not found in path. Install binary from github?"; then
        (
            d=$(mktemp -d)
            cd "$d"
            curl -fLo rg.tar.gz "$RG_LINK"
            tar xfz rg.tar.gz
            cp ripgrep*/rg ~/.local/bin/
        )
        echo "Ripgrep installed to ~/.local/bin/rg"
    fi
fi

if ! which fzf; then
    if confirm "fzf not found in path. Install binary from github?"; then
        (
            d=$(mktemp -d)
            cd "$d"
            curl -fLo fzf.tar.gz "$FZF_LINK"
            tar xfz fzf.tar.gz
            cp fzf ~/.local/bin/
        )
        echo "fzf installed to ~/.local/bin/fzf"
    fi
fi

bashrcinc='. "'"$DOTFILES/bashrc.inc"'"'
if match=$(grep -F "$bashrcinc" ~/.bashrc) && [ "$match" = "$bashrcinc" ]; then
    >&2 echo "bashrc.inc already included in ~/.bashrc."
else
    >&2 echo "Including bashrc.inc in ~/.bashrc."
    echo "$bashrcinc" >> ~/.bashrc
fi

# Git config + aliases:
git config --global include.path "$DOTFILES/gitconfig"
