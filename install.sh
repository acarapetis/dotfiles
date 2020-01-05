#!/bin/bash -e

cd "$(dirname "$0")"

if ! which nvim; then
    read -p "nvim not found in path. Install appimage from github? [Y/n]" o
    if [ -z "$o" ] || [ "${o^^}" == Y ]; then
        [ ! -f nvim.appimage ] && curl -fL -o nvim.appimage --create-dirs \
            "https://github.com/neovim/neovim/releases/download/v0.4.3/nvim.appimage"
        chmod +x nvim.appimage
        ./nvim.appimage --appimage-extract >/dev/null
        [ ! -d ~/.local/bin ] && mkdir -p ~/.local/bin
        mv squashfs-root ~/.local/nvim
        ln -s ~/.local/nvim/usr/bin/nvim ~/.local/bin/
        echo "Neovim installed to ~/.local/bin/nvim"
    fi
fi

if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim  ]; then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

[ ! -d ~/.config/nvim ] && mkdir -p ~/.config/nvim
ln -s "$PWD/coc-settings.json" "$PWD/init.vim" ~/.config/nvim/ || true
ln -s "$PWD/"{.tmux.conf,.nethackrc,.pylintrc} ~/ || true

sudo pip3 -q install neovim jedi
`which nvim` +PlugInstall +qall

