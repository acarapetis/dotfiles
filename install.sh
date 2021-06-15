#!/bin/bash -e

SCRIPT_ARG="$1"
NVIM_LINK="https://github.com/neovim/neovim/releases/download/v0.4.3/nvim.appimage"
RG_API="https://api.github.com/repos/BurntSushi/ripgrep/releases"

cd "$(dirname "$0")"

[ -d ~/.local/bin ] || mkdir -p ~/.local/bin
which jq || curl https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -o ~/.local/bin/jq
ln -fs "$PWD/json2tf" ~/.local/bin/

confirm() {
    if [ "$SCRIPT_ARG" == "-y" ]; then
        return 0
    fi
    read -p "$1 [Y/n]" o
    [ -z "$o" ] || [ "${o^^}" == Y ]
}

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

if which nvim && ! which go; then
    if confirm "go not found in path. Install from yum/apt? (Needed for vim-hexokinase)"; then
        sudo yum install -y golang || sudo apt-get install -y golang
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

[ ! -d ~/.config/nvim ] && mkdir -p ~/.config/nvim
ln -fs "$PWD/coc-settings.json" "$PWD/init.vim" ~/.config/nvim/ || true
for x in tmux.conf nethackrc pylintrc; do
    ln -fs "$PWD/$x" ~/.$x || true
done

sudo pip3 -q install --upgrade pynvim jedi
`which nvim` +PlugInstall +qall
`which nvim` +"CocInstall -sync coc-pyright coc-json coc-css coc-tsserver coc-html" +qall

read -p "Add bashrc.inc to ~/.bashrc? [y/N]" o
if [ "$SCRIPT_ARG" == "-y" ] || [ "${o^^}" == Y ]; then
    echo '. "'"$PWD/bashrc.inc"'"' >> ~/.bashrc
fi

~/.local/share/nvim/plugged/fzf/install
