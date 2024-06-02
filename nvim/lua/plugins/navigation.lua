return {
    -- Navigation
    {
        "tpope/vim-vinegar",
        lazy = false,
        keys = {
            { "_", "<Plug>VinegarVerticalSplitUp" },
        },
    },
    {
        "junegunn/fzf.vim",
        dependencies = {
            {
                "junegunn/fzf",
                build = function()
                    vim.cmd("exec fzf#install()")
                end,
            },
        },
        keys = {
            { "<C-p>", "<cmd>:Files<CR>", silent = true },
            { "<C-f>", ":Rg<Space>" },
            { "<C-g>", ":Rg<Space> \b<C-R><C-W>\b<CR>" },
            { "<C-b>", "<cmd>:Buffers<CR>" },
            { "<BS>", "<cmd>:History<CR>" },
        },
        config = function()
            -- - Include hidden files, except .git/
            -- - Exclude anything in .gitignore (the default)
            vim.env.FZF_DEFAULT_COMMAND = 'rg --files --hidden -g "!.git/"'
            vim.env.FZF_DEFAULT_OPTS = "--bind ctrl-a:select-all"
            -- TODO: translate all this to lua:
            vim.cmd([[
                " C-A C-Q to send fzf results to quickfix
                function! s:build_quickfix_list(lines)
                  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
                  copen
                  cc
                endfunction

                let g:fzf_action = {
                  \ 'ctrl-q': function('s:build_quickfix_list'),
                  \ 'ctrl-t': 'tab split',
                  \ 'ctrl-s': 'split',
                  \ 'ctrl-v': 'vsplit' }
           ]])
        end,
    },
}
