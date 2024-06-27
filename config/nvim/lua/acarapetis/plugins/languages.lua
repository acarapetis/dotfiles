return {
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
    "Glench/Vim-Jinja2-Syntax",
    "tpope/vim-jdaddy",
    -- Trialing treesitter + LSP only for the following:
    --"pangloss/vim-javascript",
    --"leafgarland/typescript-vim",
    --"hashivim/vim-terraform",
    --"acarapetis/vim-sh-heredoc-highlighting",
    --"rust-lang/rust.vim",
    --"ekalinin/Dockerfile.vim",
    --"peitalin/vim-jsx-typescript",
}
