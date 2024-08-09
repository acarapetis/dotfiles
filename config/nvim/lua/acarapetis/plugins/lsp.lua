-- LSP + Completion
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
        remap("n", "gt", function() vim.lsp.buf.declaration() end, { desc = "Go to definition" })
        remap("n", "K", function() vim.lsp.buf.hover() end, { desc = "Hover" })
        remap("n", "<leader>vf", function() vim.lsp.buf.workspace_symbol() end, { desc = "Find symbol" })
        remap("n", "<leader>vd", function() vim.diagnostic.open_float() end, { desc = "Show floating diagnostics" })
        remap("n", "]d", function() vim.diagnostic.goto_next() end)
        remap("n", "[d", function() vim.diagnostic.goto_prev() end)
        remap("n", "<leader>va", function() vim.lsp.buf.code_action() end, { desc = "Code action" })
        remap("n", "<leader>vrf", function() vim.lsp.buf.references() end, { desc = "Find references" })
        remap("n", "<leader>vrn", function() vim.lsp.buf.rename() end, { desc = "Rename" })
        remap("i", "<C-]>", function() vim.lsp.buf.signature_help() end)
        remap("n", "<leader>l", toggle_diagnostics, { desc = "Toggle LSP diagnostics" })
    end,
})

-- Sort items starting with underscores last
local underscore_comparator = function(entry1, entry2)
    local _, entry1_under = entry1.completion_item.label:find "^_+"
    local _, entry2_under = entry2.completion_item.label:find "^_+"
    entry1_under = entry1_under or 0
    entry2_under = entry2_under or 0
    if entry1_under > entry2_under then
        return false
    elseif entry1_under < entry2_under then
        return true
    end
end

-- Sort items starting with model_ last (pydantic meta fields/methods)
local pydantic_comparator = function(entry1, entry2)
    local _, entry1_model = entry1.completion_item.label:find "^model_"
    local _, entry2_model = entry2.completion_item.label:find "^model_"
    entry1_model = entry1_model or 0
    entry2_model = entry2_model or 0
    if entry1_model > entry2_model then
        return false
    elseif entry1_model < entry2_model then
        return true
    end
end

local kind_priority_list = {
    'Field', 'Variable', 'Method', 'Function', 'Constructor', 'Class', 'Interface',
    'Module', 'Property', 'Unit', 'Value', 'Enum', 'Keyword', 'Color', 'File', 'Reference',
    'Folder', 'EnumMember', 'Constant', 'Struct', 'Event', 'Operator', 'TypeParameter', 'Snippet', 'Text',
}

return {
    "neovim/nvim-lspconfig",
    {
        "folke/lazydev.nvim",
        ft = "lua",
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "nvim-snippets",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "onsails/lspkind.nvim",
        },
        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            -- Comparator to sort by kind with custom order
            local kind_enum = require("cmp.types.lsp").CompletionItemKind
            local kind_priority = {}
            for i, kind_name in ipairs(kind_priority_list) do
                kind_priority[kind_enum[kind_name]] = i
            end
            local kind_comparator = function(entry1, entry2)
                -- Sort parameter hints to the top
                local eq1 = entry1:get_word():sub(-1, -1) == "="
                local eq2 = entry2:get_word():sub(-1, -1) == "="
                if eq1 and not eq2 then
                    return true
                elseif eq2 and not eq1 then
                    return false
                end

                local kind1 = kind_priority[entry1:get_kind()]
                local kind2 = kind_priority[entry2:get_kind()]
                if kind1 ~= kind2 then
                    local diff = kind1 - kind2
                    if diff < 0 then
                        return true
                    elseif diff > 0 then
                        return false
                    end
                end
            end

            cmp.setup({
                formatting = {
                    format = lspkind.cmp_format {
                        mode = "symbol_text",
                        with_text = true,
                        menu = {
                            buffer = "[text]",
                            nvim_lsp = "[LSP]",
                            path = "[path]",
                        },
                    },

                },
                matching = {
                    disallow_fuzzy_matching = true,
                },
                sources = {
                    { name = "snippets" },
                    { name = "path" },
                    { name = "nvim_lsp" },
                    { name = "lazydev" },
                    {
                        name = "buffer",
                        keyword_length = 5,
                        option = {
                            get_bufnrs = function() return vim.api.nvim_list_bufs() end,
                        },
                    },
                },
                sorting = {
                    comparators = {
                        -- If I've started typing, prioritize best match:
                        cmp.config.compare.exact,
                        cmp.config.compare.score,

                        -- Otherwise, try to put e.g. struct members first:
                        underscore_comparator,
                        kind_comparator,
                        pydantic_comparator,

                        -- Finally, alphabetical order
                        cmp.config.compare.sort_text,
                    },
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-j>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                }),
            })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "mason.nvim", "hrsh7th/cmp-nvim-lsp" },
        config = function()
            local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

            require("mason").setup({})
            require("mason-lspconfig").setup({
                ensure_installed = { "tsserver", "lua_ls", "pyright", "ruff" },
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
                },
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
    }
}
