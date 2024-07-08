vim.keymap.set("x", "<leader>j", ":!json2tf<CR>$=%")
vim.keymap.set("n", "<leader>t", ":!pytest -x<CR>")
vim.keymap.set("n", "<leader>T", ":!pytest %<CR>")

vim.keymap.set("n", "<leader>Fl", vim.lsp.buf.format, { desc = "Format buffer using LSP" })
vim.keymap.set("n", "<leader>Fb", "<cmd>silent !black %<CR>", { desc = "Format buffer using black" })
vim.keymap.set("n", "<leader>Fr", "<cmd>silent !ruff format %<CR>", { desc = "Format buffer using ruff" })

vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste over selection" })
vim.keymap.set({"n", "v"}, "<leader>D", '"_d', { desc = "Delete without yank" })

vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz", { desc = "Next quickfix" })
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz", { desc = "Prev quickfix" })

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Find and edit word under cursor" })
vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]], { desc = "Find and replace word under cursor" })

vim.keymap.set("n", "*", [[/\C\<<C-r><C-w>\><CR>]], { silent = true })
vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo comment" })

-- makes * and # work on visual mode too.
-- pinched from https://old.reddit.com/r/neovim/comments/ng1ea0/comment/gyp87k5/
vim.cmd([[
  function! g:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
  endfunction

  xnoremap * :<C-u>call g:VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
  xnoremap # :<C-u>call g:VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
]])


