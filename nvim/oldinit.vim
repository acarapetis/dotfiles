au FileType xml setlocal foldmethod=syntax
au BufNewFile,BufRead *.hcl set ft=terraform
autocmd FileType rst set ts=3 | set sw=3

"""""""""""
" Start coc config
let g:coc_global_extensions = [
      \ 'coc-json',
      \ 'coc-snippets',
      \ 'coc-html',
      \ 'coc-tsserver',
      \ 'coc-rls',
      \ 'coc-pyright',
      \ 'coc-css',
      \ ]

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
" xmap ga <Plug>(EasyAlign)
" nmap ga <Plug>(EasyAlign)

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
