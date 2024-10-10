return {
    {
        "stevearc/conform.nvim",
        config = function()
            local prettier = { "prettierd", "prettier", stop_after_first = true }
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "ruff_fix", "ruff_format" },
                    rust = { "rustfmt", lsp_format = "fallback" },
                    terraform = { "terraform_fmt" },
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
                formatters = {
                    ruff_fix = {
                        append_args = { "--select", "I,F" },
                    },
                },
            })
        end,
        keys = {
            { "<leader>F", function() require("conform").format() end, desc = "autoformat" },
        },
    },
}
