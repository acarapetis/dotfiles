return {
    "tpope/vim-commentary",
    "tpope/vim-dadbod",
    "tpope/vim-speeddating",
    "tpope/vim-eunuch",
    "tpope/vim-surround",
    "tpope/vim-repeat",
    "tpope/vim-sleuth",
    "tpope/vim-abolish",

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
                ["<leader>f"] = { name = "+format..." },
                ["<leader>r"] = { name = "+refactor..." },
                ["<leader>v"] = { name = "+lsp..." },
                ["<leader>x"] = { name = "+trouble..." },
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            wk.register(opts.defaults)
        end,
    },
}
