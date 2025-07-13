vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
    callback = function(event)
        local remap = function(mode, key, action, opts)
            local opts2 = vim.tbl_extend("keep", opts or {}, { buffer = event.buf })
            vim.keymap.set(mode, key, action, opts2)
        end

        local toggle_diagnostics = function()
            local bn = vim.api.nvim_get_current_buf()
            local enabled = vim.diagnostic.is_enabled({ bufnr = bn })
            vim.diagnostic.enable(not enabled, { bufnr = bn })
        end

        -- make gq work:
        vim.bo[event.buf].formatexpr = nil

        remap("n", "gd", function() vim.lsp.buf.definition() end, { desc = "Go to definition" })
        remap("n", "gt", function() vim.lsp.buf.declaration() end, { desc = "Go to declaration" })
        remap("n", "gC", function() vim.lsp.buf.implementation() end, { desc = "Go to implementation" })
        remap("n", "K", function() vim.lsp.buf.hover() end, { desc = "Hover" })
        remap("n", "<leader>vf", function() vim.lsp.buf.workspace_symbol() end, { desc = "Find symbol" })
        remap("n", "<leader>vd", function() vim.diagnostic.open_float() end, { desc = "Show floating diagnostics" })
        remap("n", "<leader>va", function() vim.lsp.buf.code_action() end, { desc = "Code action" })
        remap("n", "<leader>vrf", function() vim.lsp.buf.references() end, { desc = "Find references" })
        remap("n", "<leader>vrn", function() vim.lsp.buf.rename() end, { desc = "Rename" })
        remap("i", "<C-]>", function() vim.lsp.buf.signature_help() end)
        remap("n", "<leader>l", toggle_diagnostics, { desc = "Toggle LSP diagnostics" })
    end,
})

return {
    "neovim/nvim-lspconfig",
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "mason.nvim", "saghen/blink.cmp" },
        config = function()
            local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()

            require("mason").setup({})
            require("mason-lspconfig").setup({
                ensure_installed = { "ts_ls", "lua_ls", "pyright", "ruff", "emmet_ls" },
                handlers = {
                    function(server_name)
                        require("lspconfig")[server_name].setup({
                            capabilities = lsp_capabilities,
                        })
                    end,
                    pyright = function()
                        require("lspconfig").pyright.setup({
                            capabilities = lsp_capabilities,
                            settings = {
                                pyright = {
                                    analysis = {
                                        typeCheckingMode = "standard",
                                    },
                                },
                            },
                        })
                    end,
                    lua_ls = function()
                        require("lspconfig").lua_ls.setup({
                            capabilities = lsp_capabilities,
                            settings = {
                                Lua = {
                                    runtime = {
                                        version = "LuaJIT",
                                    },
                                    diagnostics = {
                                        globals = { "vim" },
                                    },
                                    workspace = {
                                        library = {
                                            vim.env.VIMRUNTIME,
                                        },
                                    },
                                },
                            },
                        })
                    end,
                    ansiblels = function()
                        require("lspconfig").ansiblels.setup({
                            cmd = { "ansible-language-server", "--stdio" },
                            settings = {
                                ansible = {
                                    python = {
                                        interpreterPath = "python",
                                    },
                                    ansible = {
                                        path = "ansible",
                                    },
                                    executionEnvironment = {
                                        enabled = false,
                                    },
                                    validation = {
                                        enabled = true,
                                        lint = {
                                            enabled = true,
                                            path = "ansible-lint",
                                        },
                                    },
                                },
                            },
                            filetypes = { "yaml.ansible" },
                            single_file_support = true,
                        })
                    end,
                },
            })
            vim.diagnostic.config({
                -- For hints (e.g. "unused parameter"), don't show virtual text or sign
                virtual_text = { severity = { min = "INFO" } },
                signs = { severity = { min = "INFO" } },
            })
        end,
    },
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        opts = {},
        dependencies = { "mini.nvim" },
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>xs",
                "<cmd>Trouble symbols toggle focus=true win.position=left win.size=30<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>xr",
                "<cmd>Trouble lsp toggle focus=true win.position=left win.size=50<cr>",
                desc = "LSP (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },
}
