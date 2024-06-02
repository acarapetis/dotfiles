return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "c",
                    "lua",
                    "cpp",
                    "rust",
                    "python",
                    "javascript",
                    "typescript",
                    "bash",
                    "perl",
                    "html",
                    "xml",
                    "json",
                    "yaml",
                    "toml",
                    "sql",
                    "proto",
                    "vim",
                    "vimdoc",
                },
                sync_install = false,
                auto_install = true,
                highlight = { enable = true, additional_vim_regex_highlighting = false },
                -- indent = { enable = true },
            })
        end,
    }
}
