return {
    { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            {
                "acarapetis/nvim-treesitter-jjconfig",
                branch = "main",
                lazy = false,
                opts = {},
            },
        },
        build = ":TSUpdate",
        config = function()
            local ts = require("nvim-treesitter")

            -- Install parsers that were previously in ensure_installed.
            -- auto_install is gone in the main branch; parsers must be installed
            -- explicitly (or on demand via :TSInstall). This runs async at startup.
            ts.install({
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
                "styled",
                "jjconfig",
                "jjrevset",
                "jjtemplate",
                "jjui",
            })

            local highlight_disable = { tmux = true, json = true, xml = true, csv = true, jinja = true }
            local indent_disable = { json = true, xml = true, csv = true, python = true }

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "*",
                callback = function(ev)
                    if not highlight_disable[ev.match] then
                        pcall(vim.treesitter.start, ev.buf)
                    end

                    if not indent_disable[ev.match] then
                        vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })

            vim.opt.foldmethod = "expr"
            vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.opt.foldenable = false -- don't fold at startup
            vim.opt.foldlevel = 99 -- when enabled, start with all folds open
        end,
    },
    {
        "MeanderingProgrammer/treesitter-modules.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<CR>",
                    scope_incremental = "<CR>",
                    node_incremental = "<TAB>",
                    node_decremental = "<S-TAB>",
                },
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        config = function()
            require("nvim-treesitter-textobjects").setup({
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
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
                    swap_next = { ["<leader>a"] = "@parameter.inner" },
                    swap_previous = { ["<leader>A"] = "@parameter.inner" },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
                    goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
                    goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
                    goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        lazy = false,
        opts = {
            mode = "topline",
            max_lines = 5,
            trim_scope = "inner",
        },
        -- stylua: ignore
        keys = {
            { "<Leader>c", vim.cmd.TSContextToggle, desc = "Toggle context" },
            { "[C", function() require("treesitter-context").go_to_context(vim.v.count1) end, desc = "Jump to context" },
        },
    },
    {
        "danymat/neogen",
        version = "*",
        keys = {
            {
                "<Leader>vD",
                function() require("neogen").generate({}) end,
                desc = "Generate docstring",
            },
        },
        opts = {
            enabled = true,
            languages = {
                python = {
                    template = { annotation_convention = "numpydoc" },
                },
            },
        },
    },
}
