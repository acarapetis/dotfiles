return {
    "tpope/vim-dadbod", -- for interactive SQL querying
    "tpope/vim-speeddating", -- C-A/C-X support for datetimes
    "tpope/vim-eunuch", -- file operations (rename, move, delete, chmod)
    "tpope/vim-repeat", -- makes . behave better with plugins
    "tpope/vim-sleuth", -- automatically detect tab/space indent standard
    "tpope/vim-abolish", -- actions for snake/camel/etc conversions

    {
        "junegunn/vim-easy-align",
        keys = {
            { "ga", mode = { "x", "n" }, "<Plug>(EasyAlign)", desc = "EasyAlign" },
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            scope = { enabled = false },
        },
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            keywords = {
                FIX = {
                    icon = " ",
                    color = "error",
                    alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
                },
                TODO = { icon = " ", color = "info" },
                HACK = { icon = " ", color = "warning" },
                WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
            },
            highlight = {
                pattern = [[.*<(KEYWORDS)\s*]],
                keyword = "wide_bg",
            },
        },
        event = "VimEnter",
        config = function(_, opts)
            require("todo-comments").setup(opts)
            local configure_for_filetype = function(ev)
                local config = require("todo-comments.config")
                local is_doc = vim.tbl_contains({ "markdown", "text", "rst" }, vim.bo.filetype)
                config.options.highlight.comments_only = not is_doc
            end
            vim.api.nvim_create_autocmd("BufEnter", {
                desc = "Enable todo-comments for text documents",
                group = vim.api.nvim_create_augroup("user.todo.text", { clear = true }),
                callback = configure_for_filetype,
            })
            configure_for_filetype()
        end,
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            vim.o.termguicolors = true
            require("colorizer").setup({}, { names = false })
        end,
    },
    {
        "folke/noice.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        config = function()
            require("noice").setup({
                cmdline = {
                    view = "cmdline",
                    format = { cmdline = { pattern = "^:", conceal = false, icon = "", lang = "vim" } },
                },
                lsp = {
                    override = {
                        -- Human-readable markdown rendering in pyright popups :)
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                messages = { view_search = false },
                presets = {
                    bottom_search = true,
                    long_message_to_split = true,
                },
            })
        end,
    },
}
