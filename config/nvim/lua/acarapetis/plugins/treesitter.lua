---@diagnostic disable: missing-fields
return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
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
                    "regex",
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                    disable = { "tmux", "dockerfile", "json", "xml", "csv", "jinja" },
                },
                indent = {
                    enable = true,
                    disable = { "json", "xml", "csv", "python" },
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
                textobjects = {
                    select = {
                        enable = true,

                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,

                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            -- You can also use captures from other query groups like `locals.scm`
                            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                        },
                        selection_modes = {
                            ["@parameter.outer"] = "v",
                            ["@function.outer"] = "V",
                            ["@class.outer"] = "V",
                        },
                        include_surrounding_whitespace = false,
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>a"] = "@parameter.inner",
                        },
                        swap_previous = {
                            ["<leader>A"] = "@parameter.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]f"] = "@function.outer",
                            ["]c"] = "@class.outer",
                        },
                        goto_next_end = {
                            ["]F"] = "@function.outer",
                            ["]C"] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[f"] = "@function.outer",
                            ["[c"] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[F"] = "@function.outer",
                            ["[C"] = "@class.outer",
                        },
                    },
                },
            })

            vim.cmd([[
                set foldmethod=expr
                set foldexpr=nvim_treesitter#foldexpr()
                set nofoldenable " Disable folding at startup.
                set foldlevelstart=99 " When folding is enabled, start with all folds open.
            ]])
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        lazy = false,
        config = function()
            require("treesitter-context").setup({
                mode = "topline",
                max_lines = 5,
                trim_scope = "inner",
            })
        end,
        -- stylua: ignore
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
                function() require("neogen").generate() end,
                desc = "Generate docstring",
            },
        },
        config = function()
            require("neogen").setup({
                enabled = true,
                languages = {
                    python = {
                        template = {
                            annotation_convention = "numpydoc",
                        },
                    },
                },
            })
        end,
    },
}
