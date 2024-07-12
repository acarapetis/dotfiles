return {
    "tpope/vim-dadbod",      -- for interactive SQL querying
    "tpope/vim-speeddating", -- C-A/C-X support for datetimes
    "tpope/vim-eunuch",      -- file operations (rename, move, delete, chmod)
    "tpope/vim-surround",
    "tpope/vim-repeat",      -- makes . behave better with plugins
    "tpope/vim-sleuth",      -- automatically detect tab/space indent standard
    "tpope/vim-abolish",     -- actions for snake/camel/etc conversions

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
                pattern = [[.*<(KEYWORDS)\s*]],
                keyword = "wide_bg",
            }
        },
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            vim.o.termguicolors = true
            require("colorizer").setup()
        end
    }
}
