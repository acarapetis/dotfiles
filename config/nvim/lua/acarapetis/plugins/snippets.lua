return {
    {
        "garymjr/nvim-snippets",
        config = function() require("snippets").setup() end,
        keys = {
            {
                "<C-q>",
                function()
                    if vim.snippet.active() then vim.snippet.stop() end
                end,
                silent = true,
                mode = "i",
            },
            {
                "<C-j>",
                function()
                    if vim.snippet.active({ direction = 1 }) then
                        vim.schedule(function() vim.snippet.jump(1) end)
                        return
                    end
                    return "<Tab>"
                end,
                expr = true,
                silent = true,
                mode = "i",
            },
            {
                "<C-j>",
                function()
                    vim.schedule(function() vim.snippet.jump(1) end)
                end,
                expr = true,
                silent = true,
                mode = "s",
            },
            {
                "<C-k>",
                function()
                    if vim.snippet.active({ direction = -1 }) then
                        vim.schedule(function() vim.snippet.jump(-1) end)
                        return
                    end
                    return "<S-Tab>"
                end,
                expr = true,
                silent = true,
                mode = { "i", "s" },
            },
        },
    },
}
