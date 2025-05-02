return {
    {
        "stevearc/conform.nvim",
        event = "VeryLazy",
        config = function()
            local prettier = { "prettierd", "prettier", stop_after_first = true }
            require("conform").setup({
                formatters_by_ft = {
                    python = { "ruff_fix", "ruff_format" },
                    terraform = { "terraform_fmt" },
                    lua = { "stylua" },
                    rust = { "rustfmt", lsp_format = "fallback" },
                    c = { "clang_format" },
                    cpp = { "clang_format" },
                    javascript = prettier,
                    javascriptreact = prettier,
                    typescript = prettier,
                    typescriptreact = prettier,
                    html = prettier,
                    json = prettier,
                    yaml = prettier,
                    css = prettier,
                    markdown = prettier,
                },
            })
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*",
                callback = function(args)
                    local ft = vim.bo[args.buf].filetype
                    if ft == "python" or ft == "terraform" then
                        require("conform").format({ bufnr = args.buf })
                    end
                end,
            })
        end,
        keys = {
            { "<leader>F", function() require("conform").format() end, desc = "autoformat" },
        },
    },
}
