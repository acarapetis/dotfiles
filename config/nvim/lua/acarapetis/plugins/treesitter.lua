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
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                    disable = { "tmux", "dockerfile" },
                },
                indent = {
                    enable = true,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<CR>",
                        scope_incremental = "<CR>",
                        node_incremental = "<TAB>",
                        node_decremental = "<S-TAB>",
                    },
                },
            })

            vim.cmd([[
                set foldmethod=expr
                set foldexpr=nvim_treesitter#foldexpr()
                set nofoldenable " Disable folding at startup.
            ]])
        end,
    },
    {
        "hiphish/rainbow-delimiters.nvim",
        config = function()
            local rainbow_delimiters = require("rainbow-delimiters")
            require("rainbow-delimiters.setup").setup({
                strategy = {
                    [""] = rainbow_delimiters.strategy["local"],
                },
                query = {
                    [""] = "rainbow-delimiters",
                    --lua = "rainbow-blocks",
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        lazy = false,
        config = function()
            require "treesitter-context".setup({
                mode = "topline",
                max_lines = 5,
                trim_scope = "inner",
            })
        end,
        keys = {
            { "<Leader>c", vim.cmd.TSContextToggle, desc = "Toggle context" },
            { "[C", function() require("treesitter-context").go_to_context(vim.v.count1) end, desc = "Jump to context" },
        }
    },
    {
        "danymat/neogen",
        -- Uncomment next line if you want to follow only stable versions
        version = "*",
        keys = {
            {
                "<Leader>vD",
                function()
                    require("neogen").generate()
                end,
                desc = "Generate docstring"
            },
        },
        config = function()
            require("neogen").setup({
                enabled = true,
                languages = {
                    python = {
                        template = {
                            annotation_convention = "numpydoc"
                        }
                    }
                }
            })
        end
    },
}
