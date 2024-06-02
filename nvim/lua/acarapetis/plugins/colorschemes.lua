return {
    {
        "morhetz/gruvbox",
        config = function()
            vim.opt.termguicolors = true
            vim.g.gruvbox_bold = "1"
            vim.g.gruvbox_contrast_dark = "hard"
            vim.g.gruvbox_improved_strings = "0"
            vim.g.gruvbox_improved_warnings = "0"
        end,
    },
    { "https://github.com/rebelot/kanagawa.nvim", lazy = true },
    { "diegoulloao/neofusion.nvim", lazy = true },
    { "oxfist/night-owl.nvim", lazy = true },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = true,
    },
    { "catppuccin/nvim", name = "catppuccin", lazy = true },
    {
        "cocopon/iceberg.vim",
        lazy = true,
        config = function()
            local white = "#f2f2f2"
            vim.api.nvim_set_hl(0, "Normal", { fg = white })
            vim.api.nvim_set_hl(0, "icebergNormalFg", { fg = white })
            vim.api.nvim_set_hl(0, "DiffText", { fg = white })
        end,
    },
}
