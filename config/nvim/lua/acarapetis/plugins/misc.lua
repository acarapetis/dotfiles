return {
    "tpope/vim-speeddating", -- C-A/C-X support for datetimes
    "tpope/vim-repeat", -- makes . behave better with plugins
    "tpope/vim-sleuth", -- automatically detect tab/space indent standard
    {
        "junegunn/vim-easy-align",
        keys = {
            { "ga", mode = { "x", "n" }, "<Plug>(EasyAlign)", desc = "EasyAlign" },
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            scope = { enabled = false },
        },
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            keywords = {
                FIX = {
                    icon = " ",
                    color = "error",
                    alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
                },
                TODO = { icon = " ", color = "info" },
                HACK = { icon = " ", color = "warning" },
                WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
            },
            highlight = {
                exclude = { "csv", "json", "xml" },
                pattern = [[.*<(KEYWORDS)\s*]],
                keyword = "wide_bg",
            },
        },
        event = "VimEnter",
        config = function(_, opts)
            require("todo-comments").setup(opts)
            local configure_for_filetype = function(ev)
                local config = require("todo-comments.config")
                local is_doc = vim.tbl_contains({ "markdown", "text", "rst" }, vim.bo.filetype)
                config.options.highlight.comments_only = not is_doc
            end
            vim.api.nvim_create_autocmd("BufEnter", {
                desc = "Enable todo-comments for text documents",
                group = vim.api.nvim_create_augroup("user.todo.text", { clear = true }),
                callback = configure_for_filetype,
            })
            configure_for_filetype()
        end,
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            vim.o.termguicolors = true
            require("colorizer").setup({}, { names = false })
        end,
    }
}
