local map = vim.keymap.set
map("x", "<leader>j", ":!json2tf<CR>$=%")
map("n", "<leader>t", ":!pytest -x<CR>", { desc = "pytest -x" })
map("n", "<leader>T", ":!pytest %<CR>", { desc = "pytest this file" })

map("n", "<leader>Fl", vim.lsp.buf.format, { desc = "Format buffer using LSP" })
map("n", "<leader>Fb", "<cmd>silent !black %<CR>", { desc = "Format buffer using black" })
map(
    "n",
    "<leader>Fr",
    "<cmd>silent %!ruff check --select ALL --fix --stdin-filename % 2>/dev/null | "
        .. "ruff format --stdin-filename % 2>/dev/null<CR>",
    { desc = "Fix + format buffer using ruff" }
)
map("n", "<leader>Fp", "<cmd>silent %!prettier --stdin-filepath %<CR>", { desc = "Format buffer using prettier" })
map("n", "<leader>Fs", "<cmd>silent %!stylua -<CR>", { desc = "Format buffer using stylua" })

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
