-- Completion: blink.cmp
---@module 'blink-cmp'
return {
    "saghen/blink.cmp",
    dependencies = {
        "echasnovski/mini.nvim",
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
    },
    version = "*",
    opts = {
        keymap = {
            preset = "none",
            ["<C-n>"] = {
                -- When no completion active, use C-n for plain keyword completion
                "select_next",
                ---@param cmp blink.cmp.API
                function(cmp) cmp.show({ providers = { "buffer" } }) end,
            },
            ["<C-p>"] = {
                -- When no completion active, use C-p as a C-space synonym
                "select_prev",
                "show",
            },
            ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-e>"] = { "hide" },
            ["<C-y>"] = { "select_and_accept" },

            ["<C-u>"] = { "scroll_documentation_up", "fallback" },
            ["<C-b>"] = { "scroll_documentation_up", "fallback" },
            ["<C-d>"] = { "scroll_documentation_down", "fallback" },
            ["<C-f>"] = { "scroll_documentation_down", "fallback" },

            ["<C-]>"] = { "show_signature", "hide_signature", "fallback" },
            ["<C-k>"] = { "show_documentation", "hide_documentation", "fallback" },
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "mono",
        },
        completion = {
            trigger = {
                show_on_keyword = false,
            },
            documentation = {
                auto_show = true,
            },
            accept = {
                auto_brackets = {
                    enabled = false,
                },
            },
        },
        signature = {
            enabled = true,
        },
        snippets = { preset = "mini_snippets" },
        sources = {
            default = { "lazydev", "lsp", "path", "snippets", "buffer" },
            providers = {
                buffer = {
                    opts = {
                        get_bufnrs = function()
                            local allOpenBuffers = vim.fn.getbufinfo({ buflisted = 1, bufloaded = 1 })
                            local allBufs = vim.iter(allOpenBuffers)
                                :filter(function(buf) return vim.bo[buf.bufnr].buftype == "" end)
                                :map(function(buf) return buf.bufnr end)
                                :totable()
                            return allBufs
                        end,
                    },
                },
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    -- make lazydev completions top priority (see `:h blink.cmp`)
                    score_offset = 100,
                },
            },
        },
    },
    opts_extend = { "sources.default" },
}
