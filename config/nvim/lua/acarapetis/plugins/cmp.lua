-- Completion: blink.cmp
return {
    "saghen/blink.cmp",
    dependencies = { "echasnovski/mini.nvim" },
    version = "*",
    opts = {
        keymap = {
            preset = "none",
            ["<C-n>"] = {
                -- When no completion active, use C-n for plain keyword completion
                "select_next",
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

            ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
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
            default = { "lsp", "path", "snippets", "buffer" },
        },
    },
    opts_extend = { "sources.default" },
}
