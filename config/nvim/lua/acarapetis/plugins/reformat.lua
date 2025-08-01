local prettier = { "prettierd", "prettier", stop_after_first = true }
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        local ft = vim.bo[args.buf].filetype
        if ft == "python" or ft == "terraform" or ft == "sh" then require("conform").format({ bufnr = args.buf }) end
    end,
})
return {
    {
        "stevearc/conform.nvim",
        event = "VeryLazy",
        opts = {
            formatters_by_ft = {
                python = { "ruff_fix", "ruff_format" },
                terraform = { "terraform_fmt" },
                lua = { "stylua" },
                rust = { "rustfmt", lsp_format = "fallback" },
                c = { "clang_format" },
                cpp = { "clang_format" },
                sh = { "shfmt" },
                javascript = prettier,
                javascriptreact = prettier,
                typescript = prettier,
                typescriptreact = prettier,
                html = prettier,
                json = prettier,
                yaml = prettier,
                css = prettier,
                markdown = prettier,
                toml = { lsp_format = "prefer" }, -- taplo does it
            },
        },
        keys = {
            { "<leader>F", function() require("conform").format() end, desc = "autoformat" },
        },
    },
}
