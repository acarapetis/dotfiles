-- Completion: blink.cmp
return {
    "saghen/blink.cmp",
    dependencies = {
        "nvim-snippets",
    },
    version = "*",
    opts = {
        keymap = {
            preset = "default" -- <C-n>, <C-p>, <C-y>
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
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },
    },
    opts_extend = { "sources.default" },
}
