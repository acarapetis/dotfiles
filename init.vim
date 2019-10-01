set nocompatible
filetype off

let g:html_indent_style1="inc" 
let g:node_host_prog = '/usr/local/bin/neovim-node-host'

call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/vim-easy-align'

" colorschemes
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline-themes'
Plug 'acarapetis/vim-colors-github'

" navigation
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-vinegar'

" git
Plug 'tpope/vim-fugitive'

" ui
Plug 'ap/vim-css-color'
Plug 'bling/vim-airline'

" completion
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" language support
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'StanAngeloff/php.vim'
Plug 'pangloss/vim-javascript'
Plug 'acarapetis/vim-html-template-literals'
Plug 'digitaltoad/vim-pug'
Plug 'leafgarland/typescript-vim'
Plug 'mhartington/nvim-typescript'
Plug 'hashivim/vim-terraform'
call plug#end()

filetype plugin indent on

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
set number relativenumber
set numberwidth=2
set ttimeoutlen=10


set guioptions-=m
set guioptions-=T
"inoremap <expr>  <C-K>   HUDG_GetDigraph()

autocmd FileType * set ts=4 | set sw=4
autocmd FileType html set tabstop=2 | set sw=2

set bg=dark
colorscheme gruvbox
let g:airline_theme='gruvbox'
let g:airline#extensions#whitespace#enabled = 0

nnoremap <silent> <C-b> :CtrlPBuffer<CR>

let g:ctrlp_custom_ignore = 'node_modules'
let $NVIM_NODE_LOG_FILE='nvim-node.log'
let $NVIM_NODE_LOG_LEVEL='warn'

autocmd FileType typescript nnoremap <buffer> <silent> K :TSDoc<CR>
autocmd FileType typescript nnoremap <buffer> <silent> <leader>tdp :TSDefPreview<CR>
autocmd FileType typescript nnoremap <buffer> <silent> <leader>tt :TSType<CR>
autocmd FileType typescript nnoremap <buffer> <silent> <c-]> :TSTypeDef<CR>
autocmd FileType json syntax match Comment +\/\/.\+$+

set updatetime=300

call airline#parts#define_function('coc_status', 'coc#status')
let g:airline_section_y = airline#section#create_right(['coc_status','ffenc'])

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

noremap <silent> <Leader>d :call CocAction('jumpDefinition')<CR>
noremap <silent> <Leader>G :Gstatus<CR>
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

