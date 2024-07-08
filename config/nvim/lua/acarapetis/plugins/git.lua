return {
    {
        "tpope/vim-fugitive",
        lazy = false,
        keys = {
            { "<leader>G", ":G",            desc = "Git command" },
            { "<leader>g", vim.cmd.G,       desc = "Git status" },
            { "gb",        vim.cmd.GBrowse, desc = "View on GitHub/Bitbucket" },
        },
        config = function()
            vim.api.nvim_create_user_command(
                "Browse",
                function(opts) vim.fn.system({ "xdg-open", opts.fargs[1] }) end,
                { nargs = 1 }
            )
        end,
    },
    "tpope/vim-rhubarb",
    "tommcdo/vim-fubitive",
}
