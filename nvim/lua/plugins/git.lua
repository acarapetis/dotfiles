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
}
