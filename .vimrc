set nocompatible
filetype off
set runtimepath=~/.vim,/var/lib/vim/addons,/usr/share/vim/vimfiles,/usr/share/vim/vim80,/usr/share/vim/vimfiles/after,/var/lib/vim/addons/after,~/.vim/after
set rtp+=~/.vim/bundle/Vundle.vim

let tern#is_show_argument_hints_enabled=1
let g:tern_show_argument_hints='on_hold'
let g:tern_map_keys=1
let g:ycm_add_preview_to_completeopt=1
let g:ycm_autoclose_preview_window_after_insertion=1

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'othree/html5.vim'
Plugin 'StanAngeloff/php.vim'
Plugin 'acarapetis/vim-colors-github'
Plugin 'ap/vim-css-color'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'chrisbra/Colorizer'
Plugin 'dracula/vim'
call vundle#end()            " required
filetype plugin indent on    " required

set autoindent
set nocindent
set backspace=eol,start,indent
set expandtab
set shiftwidth=4
set tabstop=4
set fileencodings=ucs-bom,utf-8,default,latin1
set grepprg=grep\ -H\ $*
set guifont=DejaVu\ Sans\ Mono\ 10
set helplang=en
set hidden
set hlsearch
set laststatus=2
set mouse=a
set ruler
set showcmd
set ignorecase
set smartcase
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set termencoding=utf-8
set wildmenu
set t_Co=256
set relativenumber
set numberwidth=2
set ttimeoutlen=10

colorscheme github
"let g:airline_theme='github'
let g:airline#extensions#whitespace#enabled = 0

set guioptions-=m
set guioptions-=T

autocmd FileType * set ts=4 | set sw=4
autocmd FileType html set tabstop=2 | set sw=2
"autocmd FileType javascript setlocal omnifunc=tern#Complete
" vim: set ft=vim :
