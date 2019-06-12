set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

"let tern#is_show_argument_hints_enabled=1
"let g:tern_show_argument_hints='on_hold'
"let g:tern_map_keys=1
"let g:ycm_add_preview_to_completeopt=1
"let g:ycm_autoclose_preview_window_after_insertion=1
let g:html_indent_style1="inc" 
let g:node_host_prog = '/usr/local/bin/neovim-node-host'

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" colorschemes
Plugin 'morhetz/gruvbox'
Bundle 'sonph/onehalf', {'rtp': 'vim/'}
Plugin 'vim-airline/vim-airline-themes'
Plugin 'acarapetis/vim-colors-github'
Plugin 'dracula/vim'

" navigation
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-vinegar'

" git
Plugin 'tpope/vim-fugitive'

" ui
" Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'ap/vim-css-color'
Plugin 'bling/vim-airline'

" completion
" Plugin 'Shougo/deoplete.nvim'
" Plugin 'ervandew/supertab'
Plugin 'neoclide/coc.nvim'

" language support
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'StanAngeloff/php.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'acarapetis/vim-html-template-literals'
Plugin 'digitaltoad/vim-pug'
Plugin 'leafgarland/typescript-vim'
Plugin 'mhartington/nvim-typescript'

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

