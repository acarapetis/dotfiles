set nocompatible
filetype off

let g:node_host_prog = '/usr/local/bin/neovim-node-host'

" We have to unset $DISPLAY to stop netrw from trying to save/load X
" clipboard, since this is VERY slow when using X forwarding.
" should be fixed in next neovim release by this commit:
" https://github.com/neovim/neovim/commit/5e47cf27b4d82cb0ccfa7859beaa29afb0af4bed
let $DISPLAY = ''

call plug#begin('~/.local/share/nvim/plugged')
" colorschemes
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline-themes'

" navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-rhubarb'

" git
Plug 'tpope/vim-fugitive'

" ui
Plug 'bling/vim-airline'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" misc
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-eunuch'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-abolish'

" completion
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" language support
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'acarapetis/vim-html-template-literals'
Plug 'AndrewRadev/tagalong.vim'
Plug 'digitaltoad/vim-pug'
Plug 'hashivim/vim-terraform'
Plug 'acarapetis/vim-sh-heredoc-highlighting'
Plug 'rust-lang/rust.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'tpope/vim-jdaddy'
Plug 'vim-scripts/Vim-R-plugin'
Plug 'peitalin/vim-jsx-typescript'
Plug 'LnL7/vim-nix'
Plug 'jparise/vim-graphql'

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

" Indent styles and scripts in html appropriately
let g:html_indent_style1="inc"
let g:html_indent_script1="inc"
" Highlight css inside css`` literals in javascript
let g:htl_css_templates = 1

let g:Hexokinase_optInPatterns = 'full_hex,rgb,rgba,hsl,hsla,colour_names,triple_hex'
let g:Hexokinase_highlighters = ['virtual']
let g:tagalong_filetypes = ['html', 'xml', 'jsx', 'eruby', 'ejs', 'eco', 'php', 'htmldjango', 'javascriptreact', 'typescriptreact', 'xhtml']
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

let g:pydocstring_formatter = 'numpy'

let g:coc_global_extensions = [
      \ 'coc-json',
      \ 'coc-snippets',
      \ 'coc-html',
      \ 'coc-tsserver',
      \ 'coc-rls',
      \ 'coc-pyright',
      \ 'coc-css',
      \ ]
au BufNewFile,BufRead *.hcl set ft=terraform

autocmd FileType rst set ts=3 | set sw=3

nmap _ <Plug>VinegarVerticalSplitUp

set termguicolors
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

" FZF settings:
" - Include hidden files, except .git/
" - Exclude anything in .gitignore (the default)
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden -g "!.git/"'

" We usually want to search all of the current project, not just the pwd.
" This helper function returns either the current git repo root dir, or
" failing that, just the pwd.
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2>/dev/null || pwd')[:-2]
endfunction

" Search filenames in the current project
command! ProjectFiles execute 'Files' s:find_git_root()
nnoremap <silent> <C-p> :ProjectFiles<CR>

" Search file content in the current project
command! -bang -nargs=* ProjectRg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case "
  \ .shellescape(<q-args>), 1, {'dir': s:find_git_root()}, <bang>0)
nnoremap <C-f> :ProjectRg<Space>
nnoremap <silent> <C-g> :ProjectRg<Space>\b<C-R><C-W>\b<CR>

nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <silent> <BS> :History<CR>

" C-A C-Q to send fzf results to quickfix
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

function! GFull()
  execute ':G'
  only
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'


let $NVIM_NODE_LOG_FILE='nvim-node.log'
let $NVIM_NODE_LOG_LEVEL='warn'

set updatetime=300

" contextually use tab for coc autocomplete
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
" remap for complete to use tab and <cr>
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" various simple keybinds
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent> <C-]> <C-\><C-O>:call CocActionAsync('showSignatureHelp')<cr>
noremap <silent> <Leader>d :call CocAction('jumpDefinition')<CR>
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
nnoremap <silent> <C-t> :CocCommand<CR>
nnoremap <silent> <C-k> :CocAction<CR>
nnoremap <leader>a <Plug>(coc-codeaction-selected)<CR>
"xmap <leader>a <Plug>(coc-codeaction-selected)

" bind qga to autoalign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Bind <C-L> (the usual terminal refresh bind) to clear search
nnoremap <silent> <C-l> :nohl<CR>

" Select a JSON heredoc in terraform and type \j to convert to HCL
xnoremap <leader>j :!json2tf<CR>$=%

nnoremap <leader>t :!pytest -x<CR>
nnoremap <leader>T :!pytest %<CR>

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

nnoremap <leader>G :G 
nnoremap <leader>g :G<CR>

" Change default pydocstring mapping to \D
let g:pydocstring_enable_mapping = 0
nnoremap <leader>D <Plug>(pydocstring)
nnoremap <leader>E :CocDiagnostics<CR>

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
