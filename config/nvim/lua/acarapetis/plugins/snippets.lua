return {
    {
        "garymjr/nvim-snippets",
        config = function() require("snippets").setup({ friendly_snippets = false }) end,
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
                    elseif vim.snippet.active() then
                        vim.snippet.stop()
                    else
                        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
                        local lines = vim.api.nvim_buf_get_lines(0, row - 1, row, false)
                        local line_til_cursor = string.sub(lines[1], 1, col)
                        local snippets = require("snippets").load_snippets_for_ft(vim.bo.filetype)
                        for prefix, snippet in pairs(snippets) do
                            if line_til_cursor:sub(-#prefix, -1) == prefix then
                                local body = snippet.body
                                if type(body) == "table" then body = table.concat(body, "\n") end
                                vim.schedule(function()
                                    vim.api.nvim_buf_set_lines(0, row - 1, row, false, {
                                        line_til_cursor:sub(1, -#prefix - 1),
                                    })
                                    vim.snippet.expand(body)
                                end)
                            end
                        end
                    end
                end,
                mode = "i",
            },
            {
                "<C-j>",
                function()
                    vim.schedule(function() vim.snippet.jump(1) end)
                end,
                mode = "s",
            },
            {
                "<C-k>",
                function()
                    if vim.snippet.active({ direction = -1 }) then
                        vim.schedule(function() vim.snippet.jump(-1) end)
                        return
                    end
                end,
                mode = { "i", "s" },
            },
        },
    },
}
