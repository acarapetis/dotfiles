return {
    {
        "ellisonleao/gruvbox.nvim",
        config = function()
            require("gruvbox").setup({
                contrast = "hard",
                palette_overrides = {
                    -- Darker backgrounds
                    dark0_hard = "#151515",
                    dark1 = "#222222",
                    dark2 = "#2a2a2a",
                    dark3 = "#333333",
                },
                overrides = {
                    Delimiter = { link = "GruvboxFg2" },
                    ["@constructor.lua"] = { link = "Delimiter" },
                    TreesitterContext = { bg = "#222222" },
                    TreesitterContextBottom = { underline = true, sp = "#555555" },
                    TreesitterContextLineNumber = { bg = "#222222" },
                    GitSignsCurrentLineBlame = { fg = "#666666" },
                    SignColumn = { bg = "#151515" },
                },
                strict_tabs = true,
            })
        end,
    },
    -- { "https://github.com/rebelot/kanagawa.nvim", lazy = true },
    -- { "diegoulloao/neofusion.nvim", lazy = true },
    -- { "oxfist/night-owl.nvim", lazy = true },
    -- {
    --     "rose-pine/neovim",
    --     name = "rose-pine",
    --     lazy = true,
    -- },
    -- { "catppuccin/nvim", name = "catppuccin", lazy = true },
    -- {
    --     "cocopon/iceberg.vim",
    --     lazy = true,
    --     config = function()
    --         local white = "#f2f2f2"
    --         vim.api.nvim_set_hl(0, "Normal", { fg = white })
    --         vim.api.nvim_set_hl(0, "icebergNormalFg", { fg = white })
    --         vim.api.nvim_set_hl(0, "DiffText", { fg = white })
    --     end,
    -- },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "mini.nvim" },
        config = function()
            -- Hack lualine's gruvbox-dark theme to my liking
            local gruvbox_dark = require("lualine.themes.gruvbox_dark")
            for mode in pairs(gruvbox_dark) do
                gruvbox_dark[mode].c.bg = "#242424"
                gruvbox_dark[mode].b.bg = "#363636"
                gruvbox_dark[mode].a.bg = "#484848"
                gruvbox_dark[mode].a.fg = "#ebdbb2"
            end

            require("lualine").setup({
                sections = {
                    lualine_c = { { "filename", path = 1 } },
                },
                inactive_sections = {
                    lualine_c = { { "filename", path = 1 } },
                },
            })
        end,
    },
}
