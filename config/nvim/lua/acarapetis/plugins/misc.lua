return {
    "tpope/vim-commentary",  -- gc action to comment
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
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            defaults = {
                ["<leader>f"] = { name = "+fzf..." },
                ["<leader>F"] = { name = "+format..." },
                ["<leader>r"] = { name = "+refactor..." },
                ["<leader>v"] = { name = "+lsp..." },
                ["<leader>x"] = { name = "+trouble..." },
            },
            icons = {
                separator = "->"
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            wk.register(opts.defaults)
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            scope = { enabled = false },
        },
    },

}
