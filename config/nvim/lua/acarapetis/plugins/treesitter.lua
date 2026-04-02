return {
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
                    if not highlight_disable[ev.match] then pcall(vim.treesitter.start, ev.buf) end

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
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        config = function()
            require("nvim-treesitter-textobjects").setup({
                select = {
                    enable = true,
                    lookahead = true,
                    selection_modes = {
                        ["@parameter.outer"] = "v",
                        ["@function.outer"] = "V",
                        ["@class.outer"] = "V",
                    },
                    include_surrounding_whitespace = false,
                },
                swap = { enable = true },
                move = { enable = true, set_jumps = true },
            })

            local select = require("nvim-treesitter-textobjects.select")
            local move = require("nvim-treesitter-textobjects.move")
            local swap = require("nvim-treesitter-textobjects.swap")

            vim.keymap.set(
                { "x", "o" },
                "af",
                function() select.select_textobject("@function.outer", "textobjects") end,
                { desc = "Select outer function" }
            )

            vim.keymap.set(
                { "x", "o" },
                "if",
                function() select.select_textobject("@function.inner", "textobjects") end,
                { desc = "Select inner function" }
            )

            vim.keymap.set(
                { "x", "o" },
                "ac",
                function() select.select_textobject("@class.outer", "textobjects") end,
                { desc = "Select outer class" }
            )

            vim.keymap.set(
                { "x", "o" },
                "ic",
                function() select.select_textobject("@class.inner", "textobjects") end,
                { desc = "Select inner class" }
            )

            vim.keymap.set({ "x", "o" }, "as", function()
                select.select_textobject("@scope", "locals")
            end, { desc = "Select language scope" })

            vim.keymap.set(
                "n",
                "<leader>a",
                function() swap.swap_next("@parameter.inner") end,
                { desc = "Swap next parameter" }
            )

            vim.keymap.set(
                "n",
                "<leader>A",
                function() swap.swap_previous("@parameter.inner") end,
                { desc = "Swap previous parameter" }
            )

            vim.keymap.set(
                "n",
                "]f",
                function() move.goto_next_start("@function.outer", "textobjects") end,
                { desc = "Next function start" }
            )

            vim.keymap.set(
                "n",
                "]c",
                function() move.goto_next_start("@class.outer", "textobjects") end,
                { desc = "Next class start" }
            )

            vim.keymap.set(
                "n",
                "]F",
                function() move.goto_next_end("@function.outer", "textobjects") end,
                { desc = "Next function end" }
            )

            vim.keymap.set(
                "n",
                "]C",
                function() move.goto_next_end("@class.outer", "textobjects") end,
                { desc = "Next class end" }
            )

            vim.keymap.set(
                "n",
                "[f",
                function() move.goto_previous_start("@function.outer", "textobjects") end,
                { desc = "Prev function start" }
            )

            vim.keymap.set(
                "n",
                "[c",
                function() move.goto_previous_start("@class.outer", "textobjects") end,
                { desc = "Prev class start" }
            )

            vim.keymap.set(
                "n",
                "[F",
                function() move.goto_previous_end("@function.outer", "textobjects") end,
                { desc = "Prev function end" }
            )

            vim.keymap.set(
                "n",
                "[C",
                function() move.goto_previous_end("@class.outer", "textobjects") end,
                { desc = "Prev class end" }
            )
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
