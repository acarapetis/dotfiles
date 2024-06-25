vim.keymap.set("x", "<leader>j", ":!json2tf<CR>$=%")
vim.keymap.set("n", "<leader>t", ":!pytest -x<CR>")
vim.keymap.set("n", "<leader>T", ":!pytest %<CR>")

vim.keymap.set("n", "<leader>fl", vim.lsp.buf.format, { desc = "Format buffer using LSP" })
vim.keymap.set("n", "<leader>fb", "<cmd>silent !black %<CR>", { desc = "Format buffer using black" })

vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste over selection" })
vim.keymap.set({"n", "v"}, "<leader>d", '"_d', { desc = "Delete without yank" })

vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz", { desc = "Next quickfix" })
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz", { desc = "Prev quickfix" })

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Find and edit word under cursor" })
vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]], { desc = "Find and replace word under cursor" })

vim.keymap.set("n", "*", [[/\C\<<C-r><C-w>\><CR>]], { silent = true })
