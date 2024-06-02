return {
    {
        "ellisonleao/gruvbox.nvim",
        config = function()
            require("gruvbox").setup({
                contrast = "hard",
                palette_overrides = {
                    dark0_hard = "#111111",
                    dark1 = "#282828",
                },
            })
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
