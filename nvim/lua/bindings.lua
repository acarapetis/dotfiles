vim.cmd([[
  xnoremap <leader>j :!json2tf<CR>$=%
  nnoremap <leader>t :!pytest -x<CR>
  nnoremap <leader>T :!pytest %<CR>
]])
