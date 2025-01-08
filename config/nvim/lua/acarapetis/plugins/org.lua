return {
    {
        "jakewvincent/mkdnflow.nvim",
        config = function()
            require("mkdnflow").setup({
                --modules = { cmp = true },
                mappings = {
                    MkdnDecreaseHeading = false, -- I use - for browsing parent directory
                }
            })
        end,
    },
}
