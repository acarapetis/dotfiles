return {
    {
        "ellisonleao/gruvbox.nvim",
        config = function()
            require("gruvbox").setup({
                contrast = "hard",
                palette_overrides = {
                    -- Darker backgrounds
                    dark0_hard = "#151515",
                    dark1 = "#1c1c1c",
                    dark2 = "#242424",
                    dark3 = "#363636",
                },
                overrides = {
                    Delimiter = { link = "GruvboxFg2" },
                    ["@constructor.lua"] = { link = "Delimiter" },
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
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local theme = require("lualine.themes.gruvbox_dark")
            for mode in pairs(theme) do
                theme[mode].c.bg = "#242424"
                theme[mode].b.bg = "#363636"
                theme[mode].a.bg = "#484848"
                theme[mode].a.fg = "#ebdbb2"
            end
            theme.inactive.c.bg = "#181818"

            require("lualine").setup({
                options = { theme = theme },
            })
        end,
    },
}
