return {
    {
        "AndrewRadev/tagalong.vim",
        init = function()
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
    -- Trialing treesitter + LSP only for the following:
    -- "tpope/vim-jdaddy",
    --"pangloss/vim-javascript",
    --"leafgarland/typescript-vim",
    --"hashivim/vim-terraform",
    --"acarapetis/vim-sh-heredoc-highlighting",
    --"rust-lang/rust.vim",
    --"ekalinin/Dockerfile.vim",
    --"peitalin/vim-jsx-typescript",
    -- {
    --     "acarapetis/vim-html-template-literals",
    --     init = function()
    --         vim.g.htl_css_templates = 1
    --     end,
    -- },
}
