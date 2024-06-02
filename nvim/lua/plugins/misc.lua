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
            { "ga", mode = { "x", "n" }, "<Plug>(EasyAlign)" },
        },
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup()
        end,
    },

}
