return {
    {
        "tpope/vim-fugitive",
        lazy = false,
        keys = {
            { "<leader>G", ":G", desc="Git command" },
            { "<leader>g", vim.cmd.G, desc="Git status" },
        },
    },
    "tpope/vim-rhubarb",
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup()
        end
    },
}
