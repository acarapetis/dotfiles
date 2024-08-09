return {
    {
        "jakewvincent/mkdnflow.nvim",
        config = function()
            require("mkdnflow").setup({
                modules = { cmp = true }
            })
        end,
    },
}
