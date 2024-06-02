return {
    {
        "morhetz/gruvbox",
        config = function()
            vim.opt.bg = "dark"
            vim.opt.termguicolors = true
            vim.g.gruvbox_bold = "1"
            vim.g.gruvbox_contrast_dark = "hard"
            vim.g.gruvbox_improved_strings = "0"
            vim.g.gruvbox_improved_warnings = "0"
        end,
    },
    {
        "https://github.com/rebelot/kanagawa.nvim",
    },
    "diegoulloao/neofusion.nvim",
    "oxfist/night-owl.nvim",
    "rose-pine/neovim",
    "catppuccin/nvim",
    {
        "cocopon/iceberg.vim",
        lazy = false,
        config = function()
            vim.opt.bg = "dark" vim.cmd("colorscheme iceberg")
            local white = "#f2f2f2"
            vim.api.nvim_set_hl(0, "Normal", { fg = white })
            vim.api.nvim_set_hl(0, "icebergNormalFg", { fg = white })
            vim.api.nvim_set_hl(0, "DiffText", { fg = white })
        end,
    },
}
