return {
    -- Colorschemes
    {
        "morhetz/gruvbox",
        lazy = false,
        config = function()
            vim.opt.termguicolors = true
            vim.opt.bg = "dark"
            vim.g.gruvbox_bold = "1"
            vim.g.gruvbox_contrast_dark = "hard"
            vim.g.gruvbox_improved_strings = "0"
            vim.g.gruvbox_improved_warnings = "0"
            vim.cmd("colorscheme gruvbox")
            vim.cmd([[
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
            ]])
        end,
    },

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

                function! GFull()
                  execute ':G'
                  only
                endfunction

                let g:fzf_action = {
                  \ 'ctrl-q': function('s:build_quickfix_list'),
                  \ 'ctrl-t': 'tab split',
                  \ 'ctrl-s': 'split',
                  \ 'ctrl-v': 'vsplit' }
           ]])
        end,
    },

    -- Git
    {
        "tpope/vim-fugitive",
        lazy = false,
        keys = {
            { "<leader>G", ":G" },
            { "<leader>g", "<cmd>:G<CR>" },
        },
    },
    "tpope/vim-rhubarb",

    -- UI
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup()
        end,
    },

    -- Misc
    "tpope/vim-commentary",
    "tpope/vim-dadbod",
    "tpope/vim-speeddating",
    "tpope/vim-eunuch",
    "tpope/vim-surround",
    "tpope/vim-repeat",
    "tpope/vim-sleuth",
    "tpope/vim-abolish",
    {
        "junegunn/vim-easy-align",
        keys = {
            { "ga", mode = { "x", "n" }, "<Plug>(EasyAlign)" },
        },
    },

    -- Completion
    { "neoclide/coc.nvim", branch = "release" },

    -- Language support
    "Vimjas/vim-python-pep8-indent",
    {
        "heavenshell/vim-pydocstring",
        build = "make install",
        config = function()
            vim.g.pydocstring_enable_mapping = 0
            vim.g.pydocstring_formatter = "numpy"
        end,
        keys = {
            { "<leader>D", "<Plug>(pydocstring)" },
        },
    },
    "Glench/Vim-Jinja2-Syntax",
    "pangloss/vim-javascript",
    "leafgarland/typescript-vim",
    {
        "acarapetis/vim-html-template-literals",
        config = function()
            vim.g.htl_css_templates = 1
        end,
    },
    {
        "AndrewRadev/tagalong.vim",
        config = function()
            vim.g.tagalong_filetypes = {
                "html",
                "xml",
                "jsx",
                "php",
                "htmldjango",
                "javascriptreact",
                "typescriptreact",
                "xhtml",
            }
        end,
    },
    "hashivim/vim-terraform",
    "acarapetis/vim-sh-heredoc-highlighting",
    "rust-lang/rust.vim",
    "ekalinin/Dockerfile.vim",
    "tpope/vim-jdaddy",
    "peitalin/vim-jsx-typescript",
}
