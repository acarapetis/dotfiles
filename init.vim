set nocompatible
filetype off

let g:html_indent_style1="inc" 
let g:node_host_prog = '/usr/local/bin/neovim-node-host'

call plug#begin('~/.local/share/nvim/plugged')
" colorschemes
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline-themes'
Plug 'acarapetis/vim-colors-github'

" navigation
Plug 'ctrlpvim/ctrlp.vim'
"Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-rhubarb'

" git
Plug 'tpope/vim-fugitive'

" ui
Plug 'bling/vim-airline'
Plug 'ap/vim-css-color'

" misc
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-speeddating'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'

" completion
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" language support
Plug 'tpope/vim-jdaddy'
" Plug 'tpope/vim-sleuth'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'pangloss/vim-javascript'
Plug 'acarapetis/vim-html-template-literals'
Plug 'digitaltoad/vim-pug'
Plug 'leafgarland/typescript-vim'
Plug 'hashivim/vim-terraform'
Plug 'acarapetis/vim-sh-heredoc-highlighting'
Plug 'Glench/Vim-Jinja2-Syntax'
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
set nonumber
set ttimeoutlen=10
set list
set listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨


set guioptions-=m
set guioptions-=T
"inoremap <expr>  <C-K>   HUDG_GetDigraph()

autocmd FileType * set ts=4 | set sw=4
autocmd FileType rst set ts=3 | set sw=3
"autocmd FileType html set tabstop=2 | set sw=2

set bg=dark
let g:gruvbox_bold = '1'
"let g:gruvbox_italic = '1'
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_improved_strings = '0'
let g:gruvbox_improved_warnings = '0'
colorscheme gruvbox
"hi link pythonFunction GruvboxAquaBold
hi link pythonStatement GruvboxRedBold
hi link pythonConditional GruvboxRedBold
hi link pythonException GruvboxRedBold
hi link pythonRepeat GruvboxRedBold
hi link pythonOperator GruvboxRedBold
hi link pythonAsync GruvboxRedBold
hi CocFloating guibg=#32302f ctermbg=236
hi link CocWarningFloat GruvboxYellow
hi link CocWarningSign GruvboxYellowSign
hi link CocErrorFloat GruvboxRed
hi link CocErrorSign GruvboxRedSign
hi link CocHintFloat GruvboxGreen
hi link CocHintSign GruvboxGreenSign
hi link CocInfoFloat GruvboxBlue
hi link CocInfoSign GruvboxBlueSign
"let s:gb.dark0       = ['#282828', 235]     " 40-40-40
"hi link CocFloating GruvboxBg

let g:airline_theme='gruvbox'
let g:airline#extensions#whitespace#enabled = 0
"let g:airline_powerline_fonts = 1

nnoremap <silent> <C-b> :CtrlPBuffer<CR>

let g:ctrlp_custom_ignore = 'node_modules'
let $NVIM_NODE_LOG_FILE='nvim-node.log'
let $NVIM_NODE_LOG_LEVEL='warn'

"autocmd FileType typescript nnoremap <buffer> <silent> K :TSDoc<CR>
"autocmd FileType typescript nnoremap <buffer> <silent> <leader>tdp :TSDefPreview<CR>
"autocmd FileType typescript nnoremap <buffer> <silent> <leader>tt :TSType<CR>
"autocmd FileType typescript nnoremap <buffer> <silent> <c-]> :TSTypeDef<CR>
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

inoremap <silent><expr> <c-space> coc#refresh()
noremap <silent> <Leader>d :call CocAction('jumpDefinition')<CR>
nnoremap K :call <SID>show_documentation()<CR>
noremap <silent> <Leader>G :G<CR>
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
nnoremap <silent> <C-t> :CocCommand<CR>

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

nnoremap <silent> <C-l> :nohl<CR>
