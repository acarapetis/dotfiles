local map = vim.keymap.set
map("x", "<leader>j", ":!json2tf<CR>$=%")
map("n", "<leader>T", ":e ~/notes/TODO.md<CR>", { desc = "TODOs" })

map("x", "<leader>p", '"_dP', { desc = "Paste over selection" })
map({ "n", "v" }, "<leader>D", '"_d', { desc = "Delete without yank" })

map("n", "<C-j>", "<cmd>cnext<CR>zz", { desc = "Next quickfix" })
map("n", "<C-k>", "<cmd>cprev<CR>zz", { desc = "Prev quickfix" })

map(
    "n",
    "<leader>s",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Find and edit word under cursor" }
)
map("n", "<leader>S", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]], { desc = "Find and replace word under cursor" })

map("n", "*", [[/\C\<<C-r><C-w>\><CR>]], { silent = true })
map("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo comment" })

vim.cmd([[imap <C-d> <esc>lc1l]])
vim.cmd([[nmap <C-space> ea<C-space>]])

map("n", "H", vim.cmd.bprev)
map("n", "L", vim.cmd.bnext)

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
