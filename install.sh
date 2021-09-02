#!/bin/bash -e

SCRIPT_ARG="$1"
NVIM_LINK="https://github.com/neovim/neovim/releases/download/v0.5.0/nvim.appimage"
RG_API="https://api.github.com/repos/BurntSushi/ripgrep/releases"

cd "$(dirname "$0")"
DOTFILES="$PWD"

mkdir -p ~/.local/bin
which jq || curl https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -o ~/.local/bin/jq
ln -fs "$DOTFILES/json2tf" ~/.local/bin/

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

tryinstall golang python3-pip perl

if ! which nvim; then
    if confirm "nvim not found in path. Install appimage from github?"; then
        [ ! -f nvim.appimage ] && curl -fL -o nvim.appimage --create-dirs $NVIM_LINK
        chmod +x nvim.appimage
        ./nvim.appimage --appimage-extract >/dev/null
        mv squashfs-root ~/.local/nvim
        ln -fs ~/.local/nvim/usr/bin/nvim ~/.local/bin/
        echo "Neovim installed to ~/.local/bin/nvim"
    fi
fi

if ! which rg; then
    if confirm "rg not found in path. Install binary from github?"; then
        dl_url=$(curl $RG_API/latest | jq -r '.assets[]|select(.name|test("x86_64.*linux-musl.tar.gz"))|.browser_download_url')
        cd /tmp
        curl -fLo rg.tar.gz "$dl_url"
        tar xfz rg.tar.gz
        cp ripgrep*/rg ~/.local/bin/
        cd -
        echo "Ripgrep installed to ~/.local/bin/rg"
    fi
fi

if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim  ]; then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

mkdir -p ~/.config/nvim
mkdir -p ~/.config/coc
ln -fs "$DOTFILES/coc-settings.json" "$DOTFILES/init.vim" ~/.config/nvim/
ln -fs "$DOTFILES/ultisnips" ~/.config/coc/
for x in tmux.conf nethackrc pylintrc; do
    ln -fs "$DOTFILES/$x" ~/.$x || true
done

sudo pip3 -q install --upgrade pynvim
~/.local/bin/nvim +PlugInstall +qall

bashrcinc='. "'"$DOTFILES/bashrc.inc"'"'
if match=$(grep -F "$bashrcinc" ~/.bashrc) && [ "$match" = "$bashrcinc" ]; then
    >&2 echo "bashrc.inc already included in ~/.bashrc."
else
    >&2 echo "Including bashrc.inc in ~/.bashrc."
    echo "$bashrcinc" >> ~/.bashrc
fi

~/.local/share/nvim/plugged/fzf/install --all

# Git config + aliases:
git config --global include.path "$DOTFILES/gitconfig"
